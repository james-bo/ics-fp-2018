package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"sync"
	"errors"
)


type Mandelbrot struct {
	iterations  int
	scaleFactor float32
	offsetX     float32
	offsetY     float32
}


func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations,scaleFactor,offsetX,offsetY}
}


func (mandelbrot Mandelbrot) Generate(canvas *drawer.Image) error {
	if (mandelbrot.iterations <= 0) {
		return errors.New("Invalid iterations num in Generate!")
	}
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			X := float64(x)/float64(canvas.Width)*(2.5)-2
			Y := float64(y)/float64(canvas.Height)*(2)-1
			canvas.Set(x, y, mandelbrot.fillColor(X, Y))
		}
	}
	return nil
}


func (mandelbrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	if (mandelbrot.iterations <= 0) {
		return errors.New("Invalid iterations num in GenerateParallel!")
	}
	wg := sync.WaitGroup{}
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			wg.Add(1)
			go func (x,y int) {
				X := float64(x)/float64(canvas.Width)*(2.5)-2
				Y := float64(y)/float64(canvas.Height)*(2)-1
				canvas.Set(x, y, mandelbrot.fillColor(X, Y))
				wg.Done()
			}(x,y)
		}
	}
	return nil
}


func (mandelbrot Mandelbrot) fillColor(X float64, Y float64) color.Color {
	x := float64(0)
	y := float64(0)

	for i := 0; i < mandelbrot.iterations; i++ {
		t := X + (x*x - y*y)
		y = Y + 2*x*y 
		x = t
		if (x*x + y*y) > 4 {
			c := uint8(uint8(i))
			return color.YCbCr{Y: 255 - 50*c, Cb: 255 - 40*c, Cr: 40*c}
		}
	}
	return color.Black
}