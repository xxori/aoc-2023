import gleeunit
import gleeunit/should
import day04
import simplifile

pub fn main() {
  gleeunit.main()
}
// gleeunit test functions end in `_test`
pub fn day04_1_test() {
  let assert Ok(s) = simplifile.read("./test_data.txt")
  day04.part_1(s)
  |> should.equal(13)
}

// pub fn day01_2_test() {
//   let assert Ok(s) = simplifile.read("./test_data.txt")
//   day03.part_2(s)
//   |> should.equal(467_835)
// }
