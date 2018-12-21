package exercise

import (
	_ "image/color"
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"errors"
	"math/cmplx"
	"sync"
)

type Mandelbrot struct{
	iterations int
	scaleFactor float32
	offsetX, offsetY float32
	}
	
func clearCanvas(canvas *drawer.Image){
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			canvas.Set(x,y,color.RGBA{100,30,200,255})
		}
	}
}

func (mandelbrot Mandelbrot) Generate(canvas *drawer.Image) error {
	if mandelbrot.iterations <= 0 {
		return errors.New("Incorrect iterations Num")
	}
	
	clearCanvas(canvas)
	
	for i := 0; i < canvas.Height; i++ {
		//Complex part of c
		cy := float32(i)*mandelbrot.scaleFactor-mandelbrot.offsetY	
		for j := 0; j < canvas.Width; j++ {	
			//Real part of c
			cx := float32(j)*mandelbrot.scaleFactor-mandelbrot.offsetX
			c := complex128(complex(cx,cy))
			z := c
			for iterNum := 0; iterNum < mandelbrot.iterations; iterNum++ {
				z = cmplx.Pow(z, 2) + c
				if cmplx.Abs(z) > 4 {
					canvas.Set(j, i, color.RGBA{200,200,100,255})
					break
				}
				
			}
			
		}
	}
	
	return nil
}

func (mandelbrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	if mandelbrot.iterations <= 0 {
		return errors.New("Incorrect iterations Num")
	}
	
	clearCanvas(canvas)
	
	wg := sync.WaitGroup{}
	
	for i := 0; i < canvas.Height; i++ {
		//Complex part of c
		cy := float32(i)*mandelbrot.scaleFactor-mandelbrot.offsetY	
		for j := 0; j < canvas.Width; j++ {	
			wg.Add(1)
			//Real part of c
			cx := float32(j)*mandelbrot.scaleFactor-mandelbrot.offsetX
			c := complex128(complex(cx,cy))
			z := c
			for iterNum := 0; iterNum < mandelbrot.iterations; iterNum++ {
				z = cmplx.Pow(z, 2) + c
				if cmplx.Abs(z) > 4 {
					canvas.Set(j, i, color.RGBA{200,200,100,255})
					break
				}
			}
			wg.Done()
		}
	}
	
	return nil
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	//start here
	res := Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
	return res
}