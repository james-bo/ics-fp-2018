package funsets

object Main extends App {
  import FunSets._
  println(contains(singletonSet(1), 1))
  
  // Let's test every other FunSets method.
  
  printSet(union(Set(1, 1, 2), Set(2, 3, 5)))
  printSet(intersect(Set(1, 1, 2), Set(2, 3, 5)))
  printSet(diff(Set(1, 2, 3, 4), Set(2, 4)))
  printSet(filter(Set(1, 2, 3, 4), (x: Int) => x % 2 == 0))
  
  println(forall(Set(25, 50, 75, 100), (x: Int) => x % 25 == 0))
  println(forall(Set(-250, 0, 500, 1000, 1250), (x: Int) => x % 250 == 0))
  println(forall(Set(-2500, 0, 500, 1000), (x: Int) => x % 250 == 0))
  
  println(exists(Set(3, 2, 1, 0), (x: Int) => x < 0))
  println(exists(Set(2, 1, 0, -1), (x: Int) => x < 0))
  
  printSet(map(Set(1, 2, 3, 4), (x: Int) => x*x))
  
}
