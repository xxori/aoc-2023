import gleam/int
import gleam/string
import simplifile
import gleam/io
import gleam/regex

pub fn main() {
  let assert Ok(data) = simplifile.read("./data.txt")
  io.println("Part 1:")
  data
  |> part_1
  |> string.inspect
  |> io.println
  // io.println("Part 2:")
  // data
  // |> part_2
  // |> string.inspect
  // |> io.println
}

const opts = regex.Options(case_insensitive: False, multi_line: False)

pub fn part_1(lines: String) {
  let assert Ok(re) = regex.compile("(\\d+|\\.)", opts)
}

pub fn part_2(lines: String) {
  todo
}
