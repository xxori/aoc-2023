import gleam/string
import simplifile
import gleam/io
import gleam/list
import gleam/int

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

pub fn part_1(data: String) {
  use total, this <- list.fold(string.split(data,"\n"),0)
  let assert Ok(s) =
    this
    |> string.split(":")
    |> list.last
  let [winning, ours] =
    s
    |> string.split("|")
    |> list.map(fn(x) {
      x
      |> string.split(" ")
      |> list.filter_map(int.parse)
    })
  list.fold(
    ours,1,
    fn(acc, x) {
      case list.contains(winning, x) {
        True -> 2 * acc
        False -> acc
      }
    },
  )/2 + total
}

pub fn part_2(data: String) {
  todo
}
