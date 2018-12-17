package main

import (
  "github.com/dikderoy/imagen/drawer"
  "github.com/dikderoy/imagen/exercise"
  log "github.com/sirupsen/logrus"
  "os"
)

func main() {
  drawer.Init()
  log.Info("starting, trying to open file")
  f, err := os.OpenFile("mandelbrot-sample.png", os.O_CREATE|os.O_TRUNC|os.O_WRONLY, 0644)
  if err != nil {
    log.WithError(err).Fatal("cannot create/open file for writing")
  }
  defer f.Close()
  log.Info("Recognized parameters:")
  log.Info(" [x] Output image resolution:")
  log.WithField("width", drawer.GlobalConfig.Image.Width).Info("")
  log.WithField("height", drawer.GlobalConfig.Image.Height).Info("")
  log.Info(" [x] Mandelbrot:")
  log.WithField("iterations", drawer.GlobalConfig.Algorithm.Iterations).Info("")
  log.Info("   [*] Left complex border:")
  log.WithField("min-real", drawer.GlobalConfig.Algorithm.Real.Min).Info("")
  log.WithField("min-imag", drawer.GlobalConfig.Algorithm.Imag.Min).Info("")
  log.Info("   [*] Right complex border:")
  log.WithField("max-real", drawer.GlobalConfig.Algorithm.Real.Max).Info("")
  log.WithField("max-imag", drawer.GlobalConfig.Algorithm.Imag.Max).Info("")
  log.Info(" [x] Execution:")
  log.WithField("parallel", drawer.GlobalConfig.Algorithm.Execution.Parallel).Info("")
  i := drawer.NewImage(
    drawer.GlobalConfig.Image.Width,
    drawer.GlobalConfig.Image.Height)
  m := exercise.NewMandelbrot(
    drawer.GlobalConfig.Algorithm.Iterations,
    complex(drawer.GlobalConfig.Algorithm.Real.Min, drawer.GlobalConfig.Algorithm.Imag.Min),
    complex(drawer.GlobalConfig.Algorithm.Real.Max, drawer.GlobalConfig.Algorithm.Imag.Max))
  if drawer.GlobalConfig.Algorithm.Execution.Parallel {
    m.GenerateParallel(i)
  } else {
    m.Generate(i)
  }
  err = i.Draw(f)
  if err != nil {
    log.WithError(err).Fatal("failed generate image")
  }
  log.Info("done!")
}
