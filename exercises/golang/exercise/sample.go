package exercise

import (
	"github.com/dikderoy/imagen/drawer"
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
		
	return Mandelbrot{iterations,scaleFactor,offsetX,offsetY}
}


func (m Mandelbrot) Generate(canvas *drawer.Image) error {
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			canvas.Set(x, y, m.getColor(m.crdDot(x, y, canvas.Width, canvas.Height)))
		}
	}
	return nil
}

func (m Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	
	wg := sync.WaitGroup{}
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			
			wg.Add(1)
						go func (x,y int) {
				canvas.Set(x, y, m.getColor(m.crdDot(x, y, canvas.Width, canvas.Height)))
				
				wg.Done()
			}(x,y)
		}
	}
	return nil
}


func (m Mandelbrot) crdDot(x int, y int, width int, height int) complex128 {
	Ycrd := float64(y)/float64(height)*(2)-1
	Xcrd := float64(x)/float64(width)*(2.5)-2
	return complex(Xcrd, Ycrd)
}

func (m Mandelbrot) getColor(c complex128) color.Color {
	var z complex128
	var i = 0;
	for ; i < m.iterations && cmplx.Abs(z) <=2; i++ {
		z = (z*z) + c
	}
	if cmplx.Abs(z) <= 2 {
		return color.YCbCr{Y: 16, Cb: 128, Cr:128} 
	}
	return color.YCbCr{Y: 235, Cb: 128, Cr: 128} 
}