package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	log "github.com/sirupsen/logrus"
	"image/color"
	"sync"
	"time"
	"runtime"
)

type Mandelbrot struct {
	iterations       int
	scaleFactor      float32
	offsetX, offsetY float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	//start here
	return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

func getColor(c uint8) (uint8, uint8, uint8, uint8) {
	return 255 - 4 * c % 255, 255 - 8 * c % 255, 255 - 12 * c % 255, 255
	// return 4 * c % 255, 8 * c % 255, 12 * c % 255, 255
}

func mapPlane (x, y, mx, my, scaleFactor float32) (float32, float32) {
    fx := float32(x) * scaleFactor - mx
    fy := float32(y) * scaleFactor - my

    return fx, fy
}

func isInMandelbrotSet(x, y float32, mapX, mapY float32, iter, count int) int {
	// https://ru.wikipedia.org/wiki/%D0%9C%D0%BD%D0%BE%D0%B6%D0%B5%D1%81%D1%82%D0%B2%D0%BE_%D0%9C%D0%B0%D0%BD%D0%B4%D0%B5%D0%BB%D1%8C%D0%B1%D1%80%D0%BE%D1%82%D0%B0
	const limit = 4
	tx, ty := x*x-y*y+mapX, 2*x*y+mapY

	if (tx*tx + ty*ty < limit) && (count < iter) {
		return isInMandelbrotSet( tx, ty, mapX, mapY, iter, (count + 1) )
	} else {
		return count
	}
}

func (prms Mandelbrot) Generate(canvas *drawer.Image) error {
	start := time.Now()
	h := canvas.Height
	w := canvas.Width

	for y := 0; y < h; y++ {
		for x := 0; x < w; x++ {
			mapX, mapY := mapPlane(float32(x), float32(y), prms.offsetX, prms.offsetY, prms.scaleFactor)
			count := isInMandelbrotSet(0, 0, mapX, mapY, prms.iterations, 0)

			r, g, b, a := getColor(uint8(count))
			if (count == prms.iterations) {
				canvas.Set(x, y, color.RGBA{0, 0, 0, 255})
			} else {
				canvas.Set(x, y, color.RGBA{r, g, b, a})
			}
		}
	}
	log.Println(time.Since(start))

	return nil
}

func (prms Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	start := time.Now()
	h := canvas.Height
	w := canvas.Width

	runtime.GOMAXPROCS(8)

	var wg sync.WaitGroup

	for y := 0; y < h; y++ {
		wg.Add(1)
		go func(y int) {
			defer wg.Done()

			for x := 0; x < w; x++ {
				mapX, mapY := mapPlane(float32(x), float32(y), prms.offsetX, prms.offsetY, prms.scaleFactor)
				count := isInMandelbrotSet(0, 0, mapX, mapY, prms.iterations, 0)

				r, g, b, a := getColor(uint8(count))
				if (count == prms.iterations) {
					canvas.Set(x, y, color.RGBA{0, 0, 0, 255})
				} else {
					canvas.Set(x, y, color.RGBA{r, g, b, a})
				}
			}
		}(y)
	}
	wg.Wait()

	log.Println(time.Since(start))
	return nil
}
