package exercise

import (
	"errors"
	"golang/drawer"
	"image/color"
	"math/cmplx"
	"sync"
)

type Mandelbrot struct {
	iterations  int
	scaleFactor float32
	offsetX     float32
	offsetY     float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations: iterations, scaleFactor: scaleFactor, offsetX: offsetX, offsetY: offsetY}
}

func (mandelbrot Mandelbrot) Generate(canvas *drawer.Image) error {
	if mandelbrot.iterations <= 0 {
		return errors.New("Invalid arguments")
	}
	for i := 0; i < canvas.Width; i++ {
		for j := 0; j < canvas.Height; j++ {
			mandelbrot.paintPixel(canvas, i, j)
		}
	}
	return nil
}

func (mandelbrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	if mandelbrot.iterations <= 0 {
		return errors.New("Invalid arguments")
	}

	var waitGroup sync.WaitGroup
	waitGroup.Add(3)
	for i := 0; i < canvas.Width; i++ {
		for j := 0; j < canvas.Height; j++  {
			waitGroup.Add(1)
			mandelbrot.paintPixel(canvas, i, j)
		}
	}
	return nil
}

func (mandelbrot Mandelbrot) getColor(z complex128) color.Color {
	var v complex128
	for n := uint8(0); n < uint8(mandelbrot.iterations); n++ {
		v = v*v + z
		if cmplx.Abs(v) > 2 {
			return color.YCbCr{Y: 255 - 15*n, Cb: 0 + 15*n, Cr: 255 - 15*n}
		}
	}
	return color.Black
}

func (mandelbrot Mandelbrot) paintPixel(canvas *drawer.Image, x, y int) {
	dY := float64(float32(y) * mandelbrot.scaleFactor)
	dX := float64(float32(x) * mandelbrot.scaleFactor)
	canvas.Set(x, y, mandelbrot.getColor(complex(dX, dY)))
}
