import gleeunit
import gleeunit/should
import day06
import simplifile

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn day06_1_test() {
  let assert Ok(s) = simplifile.read("./test_data.txt")
  day06.part_1(s)
  |> should.equal(288)
}

pub fn day06_2_test() {
  let assert Ok(s) = simplifile.read("./test_data.txt")
  day06.part_2(s)
  |> should.equal(71_503)
}
