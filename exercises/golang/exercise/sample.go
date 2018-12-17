package exercise

import (
	"image/color"
	"math/cmplx"
	"sync"
	"github.com/dikderoy/imagen/drawer"
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

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	const (
		left, bottom = -2, -2
	)

	for y := 0; y < canvas.Height; y++ {
		dy := left + float32(y)*m.scaleFactor
		for x := 0; x < canvas.Width; x++ {
			dx := bottom + float32(x)*m.scaleFactor
			canvas.Set(x, y, m.getColor(complex(float64(dx), float64(dy))))
		}
	}
	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	waitGroup := sync.WaitGroup{}
	const (
		left, bottom = -2, -2
	)

	for y := 0; y < canvas.Height; y++ {
		dy := left + float32(y)*m.scaleFactor
		for x := 0; x < canvas.Width; x++ {
			dx := bottom + float32(x)*m.scaleFactor
			waitGroup.Add(1)
			go func(px, py int) {
				canvas.Set(px, py, m.getColor(complex(float64(dx), float64(dy))))
				waitGroup.Done()
			}(x, y)
		}
	}
	return nil
}

func (m Mandelbrot) getColor(z complex128) color.Color {
	var v complex128
	for n := uint8(0); n < uint8(m.iterations); n++ {
		v = v*v + z
		if cmplx.Abs(v) > 2 {
			switch {
			case n > 50:
				return color.RGBA{170, 255, 140, 255}
			default:
				logScale := math.Log(float64(n)) / math.Log(float64(m.iterations))
				return color.RGBA{255 - uint8(logScale*255), 0, 0, 255}
			}
		}
	}
	return color.Black
}
