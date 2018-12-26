package exercise

import (
	"github.com/dikderoy/imagen/drawer"
	// log "github.com/sirupsen/logrus"
	"image/color"
	"math/cmplx" //for complex
	// "fmt"
	"sync"
)

// Mandelbrot = z^2 + c
type Mandelbrot struct {
	iterations int
	scaleFactor float32
	offsetX, offsetY float32
}

func NewMandelbrot(iterations int, scaleFactor float32, offsetX, offsetY float32) drawer.MandelbrotGenerator {
	//start here
	return Mandelbrot{iterations,scaleFactor,offsetX,offsetY}
}

// interface methods realization

func (mandelbrot Mandelbrot) Generate(canvas *drawer.Image) error {
	// fmt.Printf("scaleFactor = %v\n", mandelbrot.scaleFactor)
	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			canvas.Set(x, y, mandelbrot.GetColor(x, y, mandelbrot.CalcPointC(x, y, canvas.Width, canvas.Height)))
			// canvas.Set(x, y, mandelbrot.GetColor(x, y))
			// Test:
			// canvas.Set(x, y, color.White)
		}
	}
	return nil
}

func (mandelbrot Mandelbrot) GenerateParallel(canvas *drawer.Image) error {
	var wg sync.WaitGroup

	for y := 0; y < canvas.Height; y++ {
		for x := 0; x < canvas.Width; x++ {
			// Increment the WaitGroup counter.
			wg.Add(1) 
			// Launch a goroutine
			go func(xx, yy int) {
				canvas.Set(xx, yy, mandelbrot.GetColor(xx, yy, mandelbrot.CalcPointC(xx, yy, canvas.Width, canvas.Height)))
				wg.Done()
			}(x, y)
		}
	}
	return nil
}

// func (mandelbrot Mandelbrot) RemapColor(value int, inputFrom int, inputTo int, outputFrom int, outputTo int) uint8
// {
//     return uint8((value - inputFrom) / (inputTo - inputFrom) * (outputTo - outputFrom) + outputFrom)
// }

// func (mandelbrot Mandelbrot) CalcPointC(x int, y int) complex128 {
// 	deltaX := (float32(x) + mandelbrot.offsetX) * mandelbrot.scaleFactor
// 	deltaY := (float32(y) + mandelbrot.offsetY) * mandelbrot.scaleFactor
// 	return complex(float64(deltaX), float64(deltaY))
// }

func (mandelbrot Mandelbrot) CalcPointC(x int, y int, width int, height int) complex128 {
	var becauseScaleFactor0_007 float32 = 1000.0 / 7.0
	deltaX := ((float32(x) + mandelbrot.offsetX) / float32(width) * 2 - 1) * mandelbrot.scaleFactor * becauseScaleFactor0_007
	deltaY := ((float32(y) + mandelbrot.offsetY) / float32(height) * 2 - 1) * mandelbrot.scaleFactor * becauseScaleFactor0_007
	return complex(float64(deltaX), float64(deltaY))
}

// "Method" 18 slide in lecture
func (mandelbrot Mandelbrot) GetColor(x, y int, c complex128) (col color.Color) { //именнованное возвращаемое значение
	// c := mandelbrot.CalcPointC(x, y)
	var z complex128 = c
	i := 0

	for ; i < mandelbrot.iterations && cmplx.Abs(z) <= 2; i++ {
		z = cmplx.Pow(z, 2) + c
	}
// Таким образом, если |zn|2 ≤ 4 при любом числе итераций (на практике — при всех вычисленных итерациях), то цвет точки чёрный, в противном случае он зависит от последнего значения n, при котором |zn|2 ≤ 4.
	if cmplx.Abs(z) > 2 {
		var colIndex uint16 = uint16(float64(i) / float64(mandelbrot.iterations) * 65535.0)
		// fmt.Printf("colIndex = %v\n", colIndex)
		col = color.NRGBA64{uint16(colIndex), uint16(colIndex), uint16(colIndex), 65535}
		return 
	}
	col = color.Black
	return color.Black
}
