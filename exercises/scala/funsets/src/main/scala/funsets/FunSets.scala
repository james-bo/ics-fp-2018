package funsets

import common._

/**
 * 2. Purely Functional Sets.
 */
object FunSets {
  /**
   * We represent a set by its characteristic function, i.e.
   * its `contains` predicate.
   */
  type FuncSet = Int => Boolean

  /**
   * Indicates whether a set contains a given element.
   */
  def contains(s: FuncSet, elem: Int): Boolean = s(elem)

  /**
   * Returns the set of the one given element.
   */
  def singletonSet(elem: Int): FuncSet = (x: Int) => x == elem

  /**
   * Returns the union of the two given sets,
   * the sets of all elements that are in either `s` or `t`.
   */
  def union(s: FuncSet, t: FuncSet): FuncSet = (x: Int) => s(x) || t(x)
  
  /**
   * Returns the intersection of the two given sets,
   * the set of all elements that are both in `s` and `t`.
   */
  def intersect(s: FuncSet, t: FuncSet): FuncSet = (x: Int) => s(x) && t(x)
  
  /**
   * Returns the difference of the two given sets,
   * the set of all elements of `s` that are not in `t`.
   */
  def diff(s: FuncSet, t: FuncSet): FuncSet = (x: Int) => s(x) && !t(x)
  
  /**
   * Returns the subset of `s` for which `p` holds.
   */
  def filter(s: FuncSet, p: Int => Boolean): FuncSet = (x: Int) => s(x) && p(x)

  /**
   * The bounds for `forall` and `exists` are +/- 1000.
   */
  val bound = 1000

  /**
   * Returns whether all bounded integers within `s` satisfy `p`.
   */
  def forall(s: FuncSet, p: Int => Boolean): Boolean = {
    @scala.annotation.tailrec
    def iter(a: Int): Boolean = {
      if (s(a) && !p(a)) false
      else if (a > bound) true
      else iter(a + 1)
    }
    iter(-bound)
  }
  
  /**
   * Returns whether there exists a bounded integer within `s`
   * that satisfies `p`.
   */
  def exists(s: FuncSet, p: Int => Boolean): Boolean = {
    @scala.annotation.tailrec
    def iter(a: Int): Boolean = {
      if (s(a) && p(a)) true
      else if (a > bound) false
      else iter(a + 1)
    }
    iter(-bound)
  }
  
  /**
   * Returns a set transformed by applying `f` to each element of `s`.
   */
  def map(s: FuncSet, f: Int => Int): FuncSet = (x: Int) => exists(s, (y: Int) => f(y) == x)
  
  /**
   * Displays the contents of a set
   */
  def toString(s: FuncSet): String = {
    val xs = for (i <- -bound to bound if contains(s, i)) yield i
    xs.mkString("{", ", ", "}")
  }

  /**
   * Prints the contents of a set on the console.
   */
  def printSet(s: FuncSet) {
    println(toString(s))
  }
}
