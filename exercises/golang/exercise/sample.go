package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	"image/color"
	"math"
	"sync"
)


type Mandelbrot struct {
	iterations  int
	scaleFactor float32
	offsetX, offsetY float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations:iterations, scaleFactor:scaleFactor, offsetX:offsetX, offsetY:offsetY}
}


func (fig Mandelbrot) Generate(canvas *drawer.Image) error {

	iMax := float64(100)

	for ia := 0; ia < canvas.Width; ia++ {

		var x, y float32

		for ip := 0; ip < canvas.Height; ip++ {

			cx := (fig.scaleFactor * float32(ia)) - fig.offsetX
			cy := (fig.scaleFactor * float32(ip)) - fig.offsetY

			i := 0
			x = cx
			y = cy

			for i < fig.iterations {
				x, y = x * x - y * y + cx, 2 * x * y + cy

				if math.Abs(float64(x)) > iMax &&  math.Abs(float64(y)) > iMax {
					break
				}
				i++
			}

			if i < fig.iterations {
				canvas.Set(ia, ip, color.White)
			} 
			else {
				canvas.Set(ia, ip, color.Black)
			}
			
		}


	}
	return nil

}

func (fig Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	
	iMax := float64(100)
	var wg sync.WaitGroup
	wg.Add(canvas.Width)

	for ia := 0; ia < canvas.Width; ia++ {
		var x, y float32

		go func(ia int) {
			for ip := 0; ip < canvas.Height; ip++ {
				
				cx := (fig.scaleFactor * float32(ia)) - fig.offsetX
				cy := (fig.scaleFactor * float32(ip)) - fig.offsetY

				i := 0
				x = cx
				y = cy

				for i < fig.iterations {
					x, y = x * x - y * y + cx, 2 * x * y + cy

					if math.Abs(float64(x)) > iMax &&  math.Abs(float64(y)) > iMax {
						break
					}
					i++
				}

				if i < fig.iterations {
					canvas.Set(ia, ip, color.White)
				} 
				else {
					canvas.Set(ia, ip, color.Black)
				}
				
			}
			wg.Done()
		}(ia)
	}
	wg.Wait()
	return nil

}

