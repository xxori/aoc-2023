import gleeunit
import gleeunit/should
import day08
import simplifile

pub fn main() {
  gleeunit.main()
}
// gleeunit test functions end in `_test`
pub fn day08_1_test() {
  let assert Ok(s) = simplifile.read("./test_data_1.txt")
  day08.part_1(s)
  |> should.equal(6)
}

pub fn day08_2_test() {
  let assert Ok(s) = simplifile.read("./test_data_2.txt")
  day08.part_2(s)
  |> should.equal(6)
}
