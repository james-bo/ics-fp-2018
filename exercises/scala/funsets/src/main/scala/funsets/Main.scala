package funsets

object Main extends App {

  import FunSets._

  println(contains(singletonSet(1), 1))
  println(forall(Set(2), Set(1, 2, 3)))
  printSet(union(Set(1, 2, 3), Set(4, 5, 6)))
  printSet(intersect(Set(1, 2, 4, 3), Set(4, 5, 6)))
  printSet(diff(Set(1, 2, 4, 3), Set(4, 5, 6)))
  printSet(filter(Set(1, 2, 4, 3), Set(4, 3)))
  println(exists(Set(1, 2, 4, 3), Set(3)))
}
