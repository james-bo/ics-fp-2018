package drawer

type MandelbrotGenerator interface {
	Generate(canvas *Image) error
	GenerateParallel(canvas *Image) error
}
