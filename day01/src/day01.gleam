import gleam/int
import gleam/string
import gleam/result
import gleam/list
import gleam/io
import simplifile

pub fn main() {
  let data = simplifile.read("./data.txt")
  io.println("Part 1:")
  data
  |> result.unwrap("")
  |> calibrate_1
  |> string.inspect
  |> io.println
  io.println("Part 2:")
  data
  |> result.unwrap("")
  |> calibrate_2
  |> string.inspect
  |> io.println
}

pub fn calibrate_1(lines: String) -> Int {
  lines
  |> string.split("\n")
  |> list.map(fn(x) {
    let y =
      x
      |> string.split("")
      |> list.filter_map(fn(y) { int.parse(y) })
    result.unwrap(list.first(y), 0) * 10 + result.unwrap(list.last(y), 0)
  })
  |> int.sum
}

pub fn calibrate_2(lines: String) {
  lines
  |> string.split("\n")
  |> list.map(fn(x) {
    x
    // Since we are only interested in the overall leftmost and rightmost number,
    // we can do this to prevent collisions from deleting our numbers.
    // It's kinda scuffed but it works
    |> string.replace("one", "o1e")
    |> string.replace("two", "t2e")
    |> string.replace("three", "t3e")
    |> string.replace("four", "f4e")
    |> string.replace("five", "f5e")
    |> string.replace("six", "s6e")
    |> string.replace("seven", "s7e")
    |> string.replace("eight", "e8e")
    |> string.replace("nine", "n9e")
  })
  |> string.join("\n")
  |> calibrate_1
}
