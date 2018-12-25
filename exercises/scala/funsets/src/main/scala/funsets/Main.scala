package funsets

object Main extends App {
  import FunSets._
  println(contains(singletonSet(1), 1))

  println("union")
  println(union(singletonSet(1), singletonSet(2))(0))
  println(union(singletonSet(1), singletonSet(2))(1))
  println(union(singletonSet(1), singletonSet(2))(2))

  println("intersect")
  println(intersect(union(singletonSet(1), singletonSet(2)), singletonSet(2))(0))
  println(intersect(union(singletonSet(1), singletonSet(2)), singletonSet(2))(1))
  println(intersect(union(singletonSet(1), singletonSet(2)), singletonSet(2))(2))

  println("diff")
  println(diff(union(singletonSet(1), singletonSet(2)), singletonSet(2))(0))
  println(diff(union(singletonSet(1), singletonSet(2)), singletonSet(2))(1))
  println(diff(union(singletonSet(1), singletonSet(2)), singletonSet(2))(2))

  println("filter")
  println(filter(union(singletonSet(1), singletonSet(2)), singletonSet(2))(0))
  println(filter(union(singletonSet(1), singletonSet(2)), singletonSet(2))(1))
  println(filter(union(singletonSet(1), singletonSet(2)), singletonSet(2))(2))

  println("forall")
  println(forall(singletonSet(0), union(singletonSet(1), singletonSet(2)))
  println(forall(singletonSet(1), union(singletonSet(1), singletonSet(2)))
  println(forall(singletonSet(2), union(singletonSet(1), singletonSet(2)))

  println("exists")
  println(exists(singletonSet(0), union(singletonSet(1), singletonSet(2)))
  println(exists(singletonSet(1), union(singletonSet(1), singletonSet(2)))
  println(exists(singletonSet(2), union(singletonSet(1), singletonSet(2)))

  println("map")
  println(map(union(singletonSet(1), singletonSet(3)), i => i + 1)(1))
  println(map(union(singletonSet(1), singletonSet(3)), i => i + 1)(2))
  println(map(union(singletonSet(1), singletonSet(3)), i => i + 1)(3))
  println(map(union(singletonSet(1), singletonSet(3)), i => i + 1)(4))
}
