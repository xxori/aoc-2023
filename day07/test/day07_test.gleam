import gleeunit
import gleeunit/should
import day07_1
import day07_2
import simplifile

pub fn main() {
  gleeunit.main()
}
// gleeunit test functions end in `_test`
pub fn day07_1_test() {
  let assert Ok(s) = simplifile.read("./test_data.txt")
  day07_1.part_1(s)
  |> should.equal(6440)
}

pub fn day07_2_test() {
  let assert Ok(s) = simplifile.read("./test_data.txt")
  day07_2.part_2(s)
  |> should.equal(5905)
}
