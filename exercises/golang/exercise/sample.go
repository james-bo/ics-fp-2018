package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"math/cmplx"
	"sync"
)

type Mandelbrot struct {
	iterations 	int
	scaleFactor float32
	offsetX 		float32
	offsetY 		float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot { iterations, scaleFactor, offsetX, offsetY }
}

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	for i := 0; i < canvas.Width; i++ {
		for j := 0; j < canvas.Height; j++ {
			m.setPixel(canvas, i, j)
		}
	}
	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	var wg sync.WaitGroup

	for i := 0; i < canvas.Width; i++ {
		wg.Add(1)
		for j := 0; j < canvas.Height; j++ {
			m.setPixel(canvas, i, j)
		}
		wg.Done()
	}
	wg.Wait()

	return nil
}

func (m Mandelbrot) setPixel(canvas *drawer.Image, x, y int) {
	deltaX := float64(((float32(x) - float32(canvas.Width) / 32.0 )) * m.scaleFactor - m.offsetX)
	deltaY := float64(((float32(y) - float32(canvas.Height) / 32.0 )) * m.scaleFactor - m.offsetY)
	canvas.Set(x, y, m.getColor(complex(deltaX, deltaY)))
}

func (m Mandelbrot) getColor(c complex128) color.Color {
	z := c
	i := 0

	for ; i < m.iterations && cmplx.Abs(z) <= 2; i++ {
		z = cmplx.Pow(z, 2) + c
	}

	if cmplx.Abs(z) > 2 {
		return color.YCbCr { Y: 255 - 15 * uint8(i), Cb: 15 * uint8(i), Cr: 255 - 15 * uint8(i) }
	}

	return color.Black
}
