package exercise

import (
  "github.com/dikderoy/imagen/drawer"
  "image/color"
  "math/cmplx"
  "sync"
)

type Mandelbrot struct {
  min, max complex128
  iterations int
}

func NewMandelbrot(iterations int, min, max complex128) drawer.MandelbrotGenerator {
  return Mandelbrot{min, max, iterations};
}

func (m Mandelbrot) ToZ(pixel, resol complex128) complex128 {
  x_range := real(m.max) - real(m.min)
  y_range := imag(m.max) - imag(m.min)
  min_res := min(real(resol), imag(resol))
  real := real(m.min) + real(pixel) * x_range / min_res
  imag := imag(m.min) + imag(pixel) * y_range / min_res
  return complex(real, imag);
}

func min(lhs, rhs float64) float64 {
  returnable := lhs
  if(rhs < lhs) {
    returnable = rhs
  }
  return returnable
}

func (m Mandelbrot) Calculate(z complex128) int {
  ya_z := complex(0.0, 0.0)
  var i int = 0
  for ; i < m.iterations && cmplx.Abs(ya_z) < 2; i++ {
    ya_z = ya_z * ya_z + z
  }
  return i
}

func ToColor(num int) color.RGBA {
  return color.RGBA{uint8(num % 256), uint8(num % 256), uint8(num % 256), 255}
}

func (m Mandelbrot) Generate(canvas * drawer.Image) error {
  resolution := complex(float64(canvas.Width), float64(canvas.Height))
  for y := 0; y < canvas.Height; y++ {
    for x := 0; x < canvas.Width; x++ {
      canvas.Set(x, y, m.generateImpl(resolution, x, y))
    }
  }
  return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
  resolution := complex(float64(canvas.Width), float64(canvas.Height))
  var wg sync.WaitGroup
  wg.Add(canvas.Height)
  for y := 0; y < canvas.Height; y++ {
    go func(y int) {
      var ya_wg sync.WaitGroup
      ya_wg.Add(canvas.Width)
      for x := 0; x < canvas.Width; x++ {
        go func(x int) {
          canvas.Set(x, y, m.generateImpl(resolution, x, y))
          defer ya_wg.Done()
	}(x)
      }
      ya_wg.Wait()
      defer wg.Done()
    }(y)
  }
  wg.Wait()
  return nil
}

func (m Mandelbrot) generateImpl(resolution complex128, x, y int) color.RGBA {
  pixel := complex(float64(x), float64(y))
  z := m.ToZ(pixel, resolution)
  n := m.Calculate(z)
  return ToColor(n)
}
