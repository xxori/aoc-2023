import gleam/int
import gleam/string
import gleam/result
import gleam/list
import gleam/io
import simplifile

pub fn main() {
  let assert Ok(data) = simplifile.read("./data.txt")
  io.println("Part 1:")
  data
  |> part_1
  |> string.inspect
  |> io.println
  io.println("Part 2:")
  data
  |> part_2
  |> string.inspect
  |> io.println
}

pub fn part_1(lines: String) -> Int {
  lines
  |> string.split("\n")
  |> list.fold(
    0,
    fn(acc, x) {
      let y =
        x
        |> string.split("")
        |> list.filter_map(int.parse)
      result.unwrap(list.first(y), 0) * 10 + result.unwrap(list.last(y), 0) + acc
    },
  )
}

pub fn part_2(lines: String) -> Int {
  lines
  |> string.replace("one", "o1e")
  |> string.replace("two", "t2e")
  |> string.replace("three", "t3e")
  |> string.replace("four", "f4r")
  |> string.replace("five", "f5e")
  |> string.replace("six", "s6x")
  |> string.replace("seven", "s7n")
  |> string.replace("eight", "e8t")
  |> string.replace("nine", "n9e")
  |> part_1
}
