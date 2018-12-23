package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"sync"
)

type Mandelbrot struct {
	iterations		int
	scaleFactor		float32
	offsetX 		float32
	offsetY 		float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	for yy := 0; yy < canvas.Height; yy++ {
		y := (float32(yy)/float32(canvas.Height)-0.5)/m.scaleFactor - m.offsetY
		for xx := 0; xx < canvas.Width; xx++ {
			x := (float32(xx)/float32(canvas.Width)-0.5)/m.scaleFactor - m.offsetX
			canvas.Set(xx, yy, m.GetColor(x, y))
		}
	}
	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	wg := sync.WaitGroup{}
	for yy := 0; yy < canvas.Height; yy++ {
		y := (float32(yy)/float32(canvas.Height)-0.5)/m.scaleFactor - m.offsetY
		for xx := 0; xx < canvas.Width; xx++ {
			x := (float32(xx)/float32(canvas.Width)-0.5)/m.scaleFactor - m.offsetX
			wg.Add(1)
			go func(xx, yy int) {
				canvas.Set(xx, yy, m.GetColor(x, y))
				wg.Done()
			}(xx, yy)
		}
	}
	return nil
}


func (m Mandelbrot) GetColor(x, y float32) color.Color {
	z := float32(0)
	w := float32(0)
	for i := 0; i < m.iterations; i++ {
		zz := z*z - w*w + x
		w = 2.0*z*w + y
		z = zz
		if z*z+w*w > 4 {
			return color.YCbCr{255 - 15*uint8(i), 255 - 15*uint8(i), 15 * uint8(i)}
		}
	}
	return color.Black
}
