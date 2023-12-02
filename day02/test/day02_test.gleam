import gleeunit
import gleeunit/should
import day02
import simplifile
import gleam/result

pub fn main() {
  gleeunit.main()
}

// gleeunit test functions end in `_test`
pub fn day02_1_test() {
  let s =
    simplifile.read("./test_data_1.txt")
    |> result.unwrap("")
  day02.part_1(s)
  |> should.equal(8)
}

pub fn day01_2_test() {
  let s =
    simplifile.read("./test_data_2.txt")
    |> result.unwrap("")
  day02.part_2(s)
  |> should.equal(2286)
}
