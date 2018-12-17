package drawer

import (
  log "github.com/sirupsen/logrus"
  flag "github.com/spf13/pflag"
  "github.com/spf13/viper"
  "os"
)

var GlobalConfig Config

func Init() {
  defineConfig()
  defineCommandLineConfig()
  flag.Parse()
  loadConfig()
  initLogger()
}

type Config struct {
  Log struct {
    Level string
    Colors bool
  }
  Image struct {
    Height int
    Width int
  }
  Algorithm struct {
    Iterations int
    Execution struct {
      Parallel bool
    }
    Real struct {
      Min float64
      Max float64
    }
    Imag struct {
      Min float64
      Max float64
    }
  }
}

func defineConfig() {
  viper.SetTypeByDefaultValue(true)

  defineConfigValue("Log.Level", "debug", "LOG_LEVEL")
  defineConfigValue("Log.Colors", false, "LOG_COLORS")

  viper.AutomaticEnv()
}

func defineCommandLineConfig() {
  //Resolution
  flag.IntP("width", "w", 512, "Image width")
  viper.BindPFlag("Image.Width", flag.Lookup("width"))
  flag.IntP("height", "h", 512, "Image height")
  viper.BindPFlag("Image.Height", flag.Lookup("height"))

  //Mandelbrot-algorithm-parameters
  flag.IntP("iterations", "c", 1000,
    "Mandelbrot algorithm iteration border")
  viper.BindPFlag("Algorithm.Iterations", flag.Lookup("iterations"))

  //Left-border-complex(min-real,min-imag)
  flag.Float64P("min-real", "r", -1.5,
    "Real part left border of Mandelbrot view")
  viper.BindPFlag("Algorithm.Real.min", flag.Lookup("min-real"))
  flag.Float64P("min-imag", "i", -1.0,
    "Imag part left border of Mandelbrot view")
  viper.BindPFlag("Algorithm.Imag.min", flag.Lookup("min-imag"))

  //Right-border-complex(max-real,max-imag)
  flag.Float64P("max-real", "R", 0.7,
    "Real part right border of Mandelbrot view")
  viper.BindPFlag("Algorithm.Real.max", flag.Lookup("max-real"))
  flag.Float64P("max-imag", "I", 1.0,
    "Imag part right border of Mandelbrot view")
  viper.BindPFlag("Algorithm.Imag.max", flag.Lookup("max-imag"))

  //Execution
  flag.BoolP("parallel", "p", false,
    "Compute in parallel")
  viper.BindPFlag("Algorithm.Execution.Parallel", flag.Lookup("parallel"))
}

func loadConfig() {
  defineConfig()
  err := viper.Unmarshal(&GlobalConfig)
  if err != nil {
    log.WithError(err).Fatal("failed to load configuration")
  }
}

func initLogger() {
  log.SetOutput(os.Stdout)
  level, err := log.ParseLevel(GlobalConfig.Log.Level)
  if err != nil {
    log.WithError(err).
      WithField("input", GlobalConfig.Log.Level).
      Panic("cannot determine log level")
  }
  log.SetLevel(level)
  log.SetFormatter(&log.TextFormatter{
    ForceColors: GlobalConfig.Log.Colors,
    DisableLevelTruncation: true,
  })
}

var configEnvPrefix string
func fullEnvVarName(name string) string {
  if configEnvPrefix != "" {
    name = configEnvPrefix + "_" + name
  }
  return name
}

func defineConfigValue(key string, defaultValue interface{}, envVarName string) {
  viper.SetDefault(key, defaultValue)
  viper.BindEnv(key, fullEnvVarName(envVarName))
}
