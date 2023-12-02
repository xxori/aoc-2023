import gleam/int
import gleam/string
import gleam/result
import gleam/list
import simplifile
import gleam/regex
import gleam/io
import gleam/bool
import gleam/option.{Some}

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

const opts = regex.Options(multi_line: False, case_insensitive: False)

pub fn part_1(lines: String) {
  let assert Ok(re1) = regex.compile("Game (\\d+): (.*)", opts)
  let assert Ok(re2) = regex.compile("(\\d+) (\\w+)", opts)
  lines
  |> string.split("\n")
  |> list.fold(
    0,
    fn(acc, x) {
      let [regex.Match(_, [Some(id), Some(rest)])] = regex.scan(re1, x)
      let assert Ok(id) = int.parse(id)
      let a =
        regex.scan(re2, rest)
        |> list.map(fn(y) {
          let regex.Match(_, [Some(num), Some(col)]) = y
          #(
            col,
            int.parse(num)
            |> result.unwrap(0),
          )
        })
      id * bool.to_int(
        max(list.key_filter(a, "red")) <= 12 && max(list.key_filter(a, "green")) <= 13 && max(list.key_filter(
          a,
          "blue",
        )) <= 14,
      ) + acc
    },
  )
}

fn max(l: List(Int)) -> Int {
  let assert Ok(l) =
    l
    |> list.reduce(int.max)
  l
}

pub fn part_2(lines: String) {
  let assert Ok(re) = regex.compile("(\\d+) (\\w+)", opts)
  lines
  |> string.split("\n")
  |> list.fold(
    0,
    fn(acc, x) {
      let a =
        regex.scan(re, x)
        |> list.map(fn(y) {
          let regex.Match(_, [Some(num), Some(col)]) = y
          #(
            col,
            int.parse(num)
            |> result.unwrap(0),
          )
        })
      max(list.key_filter(a, "red")) * max(list.key_filter(a, "blue")) * max(list.key_filter(
        a,
        "green",
      )) + acc
    },
  )
}
