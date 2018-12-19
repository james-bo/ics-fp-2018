package exercise

import (
	"image/color"
	"math/cmplx"
	"sync"

	"github.com/dikderoy/imagen/drawer"
)

// my original code with Mandelbrot on go (https://github.com/vslchnk/exercises-go/blob/master/donovan/3-7/3-7.go)

type Mandelbrot struct {
	iterations, contrast   uint8
	xmin, ymin, xmax, ymax float64
}

func NewMandelbrot(iterations, contrast, xmin, ymin, xmax, ymax int) drawer.MandelbrotGenerator {
	return &Mandelbrot{
		iterations: uint8(iterations),
		contrast:   uint8(contrast),
		xmin:       float64(xmin),
		ymin:       float64(ymin),
		xmax:       float64(xmax),
		ymax:       float64(ymax),
	}
}

func (m *Mandelbrot) Generate(img *drawer.Image) error {
	for py := 0; py < img.Height; py++ {
		y := float64(py)/float64(img.Height)*(m.ymax-m.ymin) + m.ymin

		for px := 0; px < img.Width; px++ {
			x := float64(px)/float64(img.Width)*(m.xmax-m.xmin) + m.xmin
			z := complex(x, y)
			// Image point (px, py) represents complex value z.
			img.Set(px, py, m.mandelbrot(z))
		}
	}

	return nil
}

func (m *Mandelbrot) GenerateParallel(img *drawer.Image) error {
	wg := sync.WaitGroup{}

	for py := 0; py < img.Height; py++ {
		y := float64(py)/float64(img.Height)*(m.ymax-m.ymin) + m.ymin

		for px := 0; px < img.Width; px++ {
			wg.Add(1)

			go func(px, py int) {
				x := float64(px)/float64(img.Width)*(m.xmax-m.xmin) + m.xmin
				z := complex(x, y)
				// Image point (px, py) represents complex value z.
				img.Set(px, py, m.mandelbrot(z))
				wg.Done()
			}(px, py)
		}

	}

	return nil
}

func (m *Mandelbrot) mandelbrot(z complex128) color.Color {
	var v complex128

	for n := uint8(0); n < m.iterations; n++ {
		v = v*v + z

		if cmplx.Abs(v) > 2 {
			return color.RGBA{255 - m.contrast*n, 0 + m.contrast*n, 0, 255}
		}
	}

	return color.Black
}
