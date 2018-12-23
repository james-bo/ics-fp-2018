package funsets

object Main extends App {
  import FunSets._
  println(contains(singletonSet(1), 1))

  var set1 = Set(1, 2, 3, 4)
  var set2 = Set(3, 4, 5, 6)

  print("set 1 contains 1: ")
  println(contains(set1, 1))
  print("set 1 contains 10: ")
  println(contains(set1, 10))

  print("singletonSet with 1: ")
  printSet(singletonSet(1))

  print("union of sets 1 and 2: ")
  printSet(union(set1, set2))

  print("intersection of sets 1 and 2: ")
  printSet(intersect(set1, set2))

  print("diff of sets 1 and 2: ")
  printSet(diff(set1, set2))

  print("filter set 1 with function checking for 1: ")
  printSet(filter(set1, f => f == 1 ))

  print("check set 1 with f > 2:")
  println(forall(set1, f => f > 2))
  print("check set 2 with f > 2:")
  println(forall(set2, f => f > 2))

  print("if exists > 3 in set 1: ")
  println(exists(set1, f => f > 3))
  print("if exists > 5 in set 1: ")
  println(exists(set1, f => f > 5))

  print("map f - 1 to set 1: ")
  printSet(map(set1, f => f - 1))
}
