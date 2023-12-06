// Naive bruteforce solution

import gleam/string
import simplifile
import gleam/io
import gleam/list
import gleam/result
import gleam/int
import gleam/bool

pub fn main() {
  let assert Ok(data) = simplifile.read("./test_data.txt")
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

pub type Race {
  Race(time: Int, record: Int)
}

pub fn part_1(data: String) {
  // use acc, x <- list.fold(parse_1(data),1)
  // acc * find_wins(x)
  data
  |> parse_1
  |> list.map(find_wins)
}

fn parse_1(data: String) -> List(Race) {
  let [t, d] =
    string.split(data, "\n")
    |> list.map(fn(x) {
      x
      |> string.to_graphemes()
      |> list.drop_while(fn(y) {
        int.parse(y)
        |> result.is_error
      })
      |> string.join("")
      |> string.split(" ")
      |> list.filter_map(int.parse)
    })
  list.zip(t, d)
  |> list.map(fn(x) {
    let #(a, b) = x
    Race(a, b)
  })
}

fn find_wins(r: Race) -> Int {
  use acc, button_time <- list.fold(list.range(1, r.time), 0)
  let distance = { r.time - button_time } * button_time
  acc + bool.to_int(distance > r.record)
}

pub fn part_2(data: String) {
  data
  |> parse_2
  |> find_wins
}

fn parse_2(data: String) -> Race {
  let [t, d] =
    string.split(data, "\n")
    |> list.map(fn(x) {
      x
      |> string.to_graphemes()
      |> list.drop_while(fn(y) {
        int.parse(y)
        |> result.is_error
      })
      |> string.join("")
      |> string.replace(" ", "")
      |> int.parse
      |> result.unwrap(0)
    })
  Race(t, d)
}
