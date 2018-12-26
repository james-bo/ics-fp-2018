package exercise

import (
	"image/color"
	"math/cmplx"
	"sync"
	"github.com/dikderoy/imagen/drawer"
)

type Mandelbrot struct {
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	m := Mandelbrot{}

	return &m
}

func (m *Mandelbrot) Generate(img *drawer.Image) error {

	const (
		xmin, ymin, xmax, ymax = -2, -2, +2, +2
	)

	height, width := img.Height, img.Width

	for py := 0; py < height; py++ {
		y := float64(py)/float64(height)*(ymax-ymin) + ymin //?
		for px := 0; px < width; px++ {
			x := float64(px)/float64(width)*(xmax-xmin) + xmin
			z := complex(x, y)
			img.Set(px, py, calculateColor(z))
		}
	}

	return nil
}

func (m *Mandelbrot) GenerateParallel(img *drawer.Image) error {

	const (
		xmin, ymin, xmax, ymax = -2, -2, +2, +2
	)

	height, width := img.Height, img.Width

	wg := sync.WaitGroup{}

	for py := 0; py < height; py++ {
		y := float64(py)/float64(height)*(ymax-ymin) + ymin //?
		for px := 0; px < width; px++ {
			x := float64(px)/float64(width)*(xmax-xmin) + xmin
			z := complex(x, y)

			wg.Add(1)
			go func(px, py int) {
				img.Set(px, py, calculateColor(z))
				wg.Done()
			}(px, py)
		}
	}

	return nil
}

func calculateColor(z complex128) color.Color {
	const iterations = 100
	const contrast = 10

	var v complex128
	for n := uint8(0); n < iterations; n++ {
		v = v*v + z
		if cmplx.Abs(v) > 2 {
			return color.YCbCr{0, 255 - contrast*n, 255 - contrast*n}
		}
	}
	return color.Black
}