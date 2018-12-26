import funsets.FunSets
import org.scalatest._

class FunSetsTest extends FunSuite {

  test("SingletonSetTest-1") {
    assert(FunSets.contains(FunSets.singletonSet(10),10) === true)
  }
  test("SingletonSetTest-2") {
    assert(FunSets.contains(FunSets.singletonSet(10),2) === false)
  }

  test("UnionTest-1") {
    assert(FunSets.contains(FunSets.union(Set(2),Set(5,10)),10) === true)
  }
  test("UnionTest-2") {
    assert(FunSets.contains(FunSets.union(Set(2),Set(5,10)),0) === false)
  }

  test("IntersectTest-1") {
    assert(FunSets.contains(FunSets.intersect(Set(2,5,10),Set(5,12)),5) === true)
  }
  test("IntersectTest-2") {
    assert(FunSets.contains(FunSets.intersect(Set(2),Set(5,10)),5) === false)
  }

  test("DiffTest-1") {
    assert(FunSets.contains(FunSets.diff(Set(2,5,10),Set(5,12)),5) === false)
  }
  test("DiffTest-2") {
    assert(FunSets.contains(FunSets.diff(Set(2),Set(5,10)),2) === true)
  }

  test("FilterTest-1") {
    assert(FunSets.contains(FunSets.filter(Set(2,5,10),Set(5,12)),12) === false)
  }
  test("FilterTest-2") {
    assert(FunSets.contains(FunSets.filter(Set(2,5,10),Set(5,10)),10) === true)
  }

  test("ForAllTest-1") {
    assert(FunSets.forall(Set(5,2,9),Set(10,5,2,6,9)) === true)
  }
  test("ForAllTest-2") {
    assert(FunSets.forall(Set(5,2,9),Set(10,5,2,69)) === false)
  }


  test("ExistsTest-1") {
    assert(FunSets.exists(Set(5,2,9),Set(10,5,2,6,9)) === true)
  }
  test("ExistsTest-2") {
    assert(FunSets.exists(Set(5,2,9),Set(-10,0)) === false)
  }


}
