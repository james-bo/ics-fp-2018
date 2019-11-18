package funsets

object Main extends App {
  import FunSets._
  println("*** `contains` function tests")
  print("{1} <- (1)" + "\n>>> ")
  println(contains(singletonSet(1), 1))
  print("{1, 2, 3} <- (1)" + "\n>>> ")
  println(contains(Set(1, 2, 3), 2))
  print("{1, 2, 3} <- (0)" + "\n>>> ")
  println(contains(Set(1, 2, 3), 0))

  println("*** `union` function tests")
  print("{1, 2} ∪ {3, 4}" + "\n>>> ")
  printSet(union(Set(1, 2), Set(3, 4)))
  print("{0} ∪ {0}" + "\n>>> ")
  printSet(union(singletonSet(0), singletonSet(0)))

  println("*** `intersect` function tests")
  print("{1, 2, 3, 4} ∩ {3, 4, 5, 6}" + "\n>>> ")
  printSet(intersect(Set(1, 2, 3, 4), Set(3, 4, 5, 6)))
  print("{0} ∩ {1, 2, 3}" + "\n>>> ")
  printSet(intersect(singletonSet(0), Set(1, 2, 3)))

  println("*** `diff` function tests")
  print("{1, 2, 3, 4} ∖ {3, 4, 5, 6}" + "\n>>> ")
  printSet(diff(Set(1, 2, 3, 4), Set(3, 4, 5, 6)))
  print("{1, 2} ∖ {1, 2}" + "\n>>> ")
  printSet(diff(Set(1, 2), Set(1, 2)))

  println("*** `filter` function tests")
  print("{1, 2, 3, 4} <- {1, 2, 3}" + "\n>>> ")
  printSet(filter(Set(1, 2, 3, 4), Set(1, 2, 3)))
  print("{1, 2, 3, 4} <- {0}" + "\n>>> ")
  printSet(filter(Set(1, 2, 3, 4), singletonSet(0)))
  print("{1, 2, 3, 4} <- [x < 3]" + "\n>>> ")
  printSet(filter(Set(1, 2, 3, 4), (x: Int) => x < 3))

  println("*** `forall` function tests")
  print("{1, 2, 3, 4, 5} <- {1, 2, 3, 4, 5}" + "\n>>> ")
  println(forall(Set(1, 2, 3, 4, 5), Set(1, 2, 3, 4, 5)))
  print("{1, 2, 3, 4, 5} <- {1, 2, 3}" + "\n>>> ")
  println(forall(Set(1, 2, 3, 4, 5), Set(1, 2, 3)))
  print("{1, 2, 3, 4, 5} <- [x > 0]" + "\n>>> ")
  println(forall(Set(1, 2, 3, 4, 5), (x: Int) => x > 0))
  print("{1, 2, 3, 4, 5} <- [x < 1]" + "\n>>> ")
  println(forall(Set(1, 2, 3, 4, 5), (x: Int) => x < 1))

  println("*** `exists` function tests")
  print("{1, 2, 3, 4, 5} <- {1, 2, 3}" + "\n>>> ")
  println(exists(Set(1, 2, 3, 4, 5), Set(1, 2, 3)))
  print("{1, 2, 3, 4, 5} <- {0}" + "\n>>> ")
  println(exists(Set(1, 2, 3, 4, 5), singletonSet(0)))
  print("{1, 2, 3, 4, 5} <- [x < 2]" + "\n>>> ")
  println(exists(Set(1, 2, 3, 4, 5), (x: Int) => x < 2))
  print("{1, 2, 3, 4, 5} <- [x > 5]" + "\n>>> ")
  println(exists(Set(1, 2, 3, 4, 5), (x: Int) => x > 5))

  println("*** `map` function tests")
  print("{0, 1, 2, 3} <- [f = x²]" + "\n>>> ")
  printSet(map(Set(0, 1, 2, 3), x => scala.math.pow(x, 2).asInstanceOf[Int]))
  print("{0, 1, 2, 3} <- [f = x & 2]" + "\n>>> ")
  printSet(map(Set(0, 1, 2, 3), x => x & 2))
}
