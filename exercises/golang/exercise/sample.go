package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	log "github.com/sirupsen/logrus"
	"image/color"
	"math/rand"
	"math"
	"time"
	"sync"
)

type Mandelbrot struct {
	iterations	int
	scaleFactor, offsetX, offsetY float32 
}

func (mandelBrot Mandelbrot) Generate(canvas *drawer.Image) error {
	rand.Seed(time.Now().UnixNano())
	randMin, randMax := 15, 250
	randSet := randMin + rand.Intn(randMax + 1)
	
	randOff := float32(0.5)//rand.Float32()
	log.WithField("randOffSet", randOff).Info("randomly generated offset factor")
	randOffx := randOff * mandelBrot.offsetX
	randOffy := randOff * mandelBrot.offsetY
	
	for x := 0; x < canvas.Width; x++ {
		randX := (float32(x)/float32(canvas.Width)) / mandelBrot.scaleFactor - randOffx
	
		for y := 0; y < canvas.Height; y++ {
			randY := (float32(y)/float32(canvas.Height)) / mandelBrot.scaleFactor - randOffy
			
			canvas.Set(x,y,mandelBrot.getColor(randX,randY,float32(randSet)))
		}
	}
	
	return nil
}

func (mandelBrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	wg := sync.WaitGroup{}
	
	rand.Seed(time.Now().UnixNano())
	randMin, randMax := 15, 250
	randSet := randMin + rand.Intn(randMax+1)
	
	randOff := rand.Float32()
	log.WithField("randOffSet", randOff).Info("randomly generated offset factor")
	randOffx := randOff * mandelBrot.offsetX
	randOffy := randOff * mandelBrot.offsetY
	
	for x := 0; x < canvas.Width; x++ {
		randX := (float32(x)/float32(canvas.Width)) / mandelBrot.scaleFactor - randOffx
		
		for y := 0; y < canvas.Height; y++ {
			randY := (float32(y)/float32(canvas.Height)) / mandelBrot.scaleFactor - randOffy
			
			wg.Add(1)
			
			go func(x,y int) {
				canvas.Set(x,y,mandelBrot.getColor(randX,randY,float32(randSet)))
				wg.Done()
			} (x,y)
		}
	}
	
	return nil
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	return Mandelbrot{iterations, scaleFactor, offsetX, offsetY}
}

func (mandelBrot Mandelbrot) getColor(ix, iy float32, cbase float32) color.Color {
	x := float32(0)
	y := float32(0)
	
	var mod float64
	var r, g, b uint8
	
	for i := 0; i < mandelBrot.iterations; i++ {
		x, y = x*x - y*y + ix, 2 * x * y + iy
		
		if float64(x*x + y*y) > math.Sqrt(float64(x)) * 4 {
			mod = float64(i) * rand.Float64()
			r, g, b = uint8(mod * mod), uint8(mod), uint8(math.Exp(mod))
			return color.RGBA{r,g,b,255}
		}
	}
	
	return color.White
}