package exercise

import (
	"image/color"
	"log"
	"math"
	"sync"
	"time"

	"../drawer"
)

//Mandelbrot structure
type Mandelbrot struct {
	iterations       int
	scaleFactor      float32
	offsetX, offsetY float32
}

// NewMandelbrot function
func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

//Generate function
func (mandel Mandelbrot) Generate(canvas *drawer.Image) error {

	max := float32(10)

	start := time.Now()

	for ix := 0; ix < canvas.Width; ix++ {
		var x float32
		var y float32

		for iy := 0; iy < canvas.Height; iy++ {

			cx := (mandel.scaleFactor * float32(ix)) - mandel.offsetX
			cy := (mandel.scaleFactor * float32(iy)) - mandel.offsetY

			x = cx
			y = cy
			i := 0

			for i < mandel.iterations {
				x, y = x*x-y*y+cx, 2*x*y+cy

				if (float32(math.Abs(float64(x))) > (max)) && (float32(math.Abs(float64(y))) > (max)) {
					break
				}

				i++
			}

			if i < mandel.iterations {
				hue := i*14 + 600
				canvas.Set(ix, iy, manColor(float64(hue)))
			} else {
				canvas.Set(ix, iy, color.RGBA{0.0, 0.0, 0.0, 255})
			}
		}
	}

	elapsed := time.Since(start)
	log.Printf("Consecutive took %s", elapsed)
	return nil
}

//GenerateParallel function
func (mandel Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	max := float32(10)

	var wg sync.WaitGroup

	start := time.Now()
	wg.Add(canvas.Width)

	for ix := 0; ix < canvas.Width; ix++ {
		var x float32
		var y float32

		go func(ix int) {
			for iy := 0; iy < canvas.Height; iy++ {
				cx := (mandel.scaleFactor * float32(ix)) - mandel.offsetX
				cy := (mandel.scaleFactor * float32(iy)) - mandel.offsetY

				x = cx
				y = cy
				i := 0

				for i < mandel.iterations {
					x, y = x*x-y*y+cx, 2*x*y+cy

					if (float32(math.Abs(float64(x))) > (max)) && (float32(math.Abs(float64(y))) > (max)) {
						break
					}

					i++
				}

				if i < mandel.iterations {
					hue := i*14 + 600
					canvas.Set(ix, iy, manColor(float64(hue)))
				} else {
					canvas.Set(ix, iy, color.RGBA{0.0, 0.0, 0.0, 255})
				}
			}

			wg.Done()
		}(ix)
	}
	wg.Wait()

	elapsed := time.Since(start)
	log.Printf("Parallel took %s", elapsed)
	return nil
}

func manColor(hue float64) color.RGBA {

	r, g, b := 0.0, 0.0, 0.0

	if hue < 600.0 {
		r = 1.0
		g = 1.0
		b = 1.0
	} else {
		r = .7
		g = .8
		b = .1
	}

	return color.RGBA{uint8(r * 255), uint8(g * 255), uint8(b * 255), 255}
}
