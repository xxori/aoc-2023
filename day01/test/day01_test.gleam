import gleeunit
import gleeunit/should
import day01
import simplifile
import gleam/result

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn day01_1_test() {
  let s =
    simplifile.read("./test_data_1.txt")
    |> result.unwrap("")
  day01.calibrate_1(s)
  |> should.equal(142)
}

pub fn day01_2_test() {
  let s =
    simplifile.read("./test_data_2.txt")
    |> result.unwrap("")
  day01.calibrate_2(s)
  |> should.equal(281)
}
