package funsets

object Main extends App {
  import FunSets._

  val oneAndTwo = union(singletonSet(1),singletonSet(2))
  println("check that union works")
  printSet(oneAndTwo)

  println("check that intersect works")
  val twoAndThree = union(singletonSet(2),singletonSet(3))
  val intersectionWithTwo = intersect(oneAndTwo, twoAndThree)
  printSet(intersectionWithTwo)

  println("check that diff works")
  val oneTwoThree = union(oneAndTwo, singletonSet(3))
  val differenceWithOneTwo = diff(oneTwoThree, singletonSet(3))
  printSet(differenceWithOneTwo)

  def isOne(a:Int): Boolean = {
    if (a.equals(1)){
      return true;
    }
    return false;
  }

  val oneAndTwoFilterOne = filter(oneAndTwo, isOne)
  println("check that filter works")
  printSet(oneAndTwoFilterOne)

  def numIsGreaterThenTwo(num: Int): Boolean = num > 2

  println("check that forall works")
  var testSet = Set(0,3,2)
  println(forall(testSet, numIsGreaterThenTwo))
  testSet = Set(3,4,5)
  println(forall(testSet, numIsGreaterThenTwo))

  println("check that exists works")
  testSet = Set(0,3,2)
  println(exists(testSet, numIsGreaterThenTwo))
  testSet = Set(0,1,2)
  println(exists(testSet, numIsGreaterThenTwo))

  def twice(num : Int): Int = {
    num*2
  }

  println("check that map works")
  val test = Set(1,2,4)
  printSet(map(test, twice))
}
