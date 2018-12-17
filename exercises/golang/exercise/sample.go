package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"math"
	"sync"
)

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {

	return Mandelbrot{
		iterations:  iterations,
		scaleFactor: scaleFactor,
		offsetX:     offsetX,
		offsetY:     offsetY,
	}
}

type Mandelbrot struct {
	iterations       int
	scaleFactor      float32
	offsetX, offsetY float32
}

func (figure Mandelbrot) Generate(canvas *drawer.Image) error {

	iterMax := float64(100)

	width := canvas.Width
	height := canvas.Height

	for px := 0; px < width; px ++ {
		var x0, y0 float32
		
		for py := 0; py < height; py++ {

			cx := (figure.scaleFactor * float32(px)) - figure.offsetX
			cy := (figure.scaleFactor * float32(py)) - figure.offsetY

			x0 = cx
			y0 = cy

			i := 0

			for i < figure.iterations {

				x0, y0 = x0 * x0 - y0 * y0 + cx, 2 * x0 * y0 + cy
	
				if math.Abs(float64(x0)) > iterMax &&  math.Abs(float64(y0)) > iterMax {
					//Means we are out of the max number of iterations
					break
				}

				i++
			}

			if i < figure.iterations {
				canvas.Set(px, py, color.Black)
			} else {
				canvas.Set(px, py, color.White)
			}
		}
	}
	
	return nil
	
}

func (figure Mandelbrot) GenerateParallel(canvas *drawer.Image) error {

	iterMax := float64(100)

	width := canvas.Width
	height := canvas.Height

	var wg sync.WaitGroup
	wg.Add(width)
	
	
	for px := 0; px < width; px ++ {

		var x0 float32
		var y0 float32

		go func(px int) {

			for py := 0; py < height; py ++ {

				cx := (figure.scaleFactor * float32(px)) - figure.offsetX
				cy := (figure.scaleFactor * float32(py)) - figure.offsetY

				x0 = cx
				y0 = cy

				i := 0

				for i < figure.iterations {

					x0, y0 = x0 * x0 - y0 * y0 + cx, 2 * x0 * y0 + cy
	
					if math.Abs(float64(x0)) > iterMax &&  math.Abs(float64(y0)) > iterMax {
						break
					}

					i++
				}

				if i < figure.iterations {
					canvas.Set(px, py, color.Black)
				} else {
					canvas.Set(px, py, color.White)
				}
			} 
			wg.Done()
		}(px)
	}

	wg.Wait()
	return nil
	
}
