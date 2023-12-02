import gleam/int
import gleam/string
import gleam/result
import gleam/list
import gleam/io
import gleam/dict.{type Dict}
import simplifile

pub fn main() {
  let data = simplifile.read("./data.txt")
  io.println("Part 1:")
  data
  |> result.unwrap("")
  |> part_1
  |> string.inspect
  |> io.println
  io.println("Part 2:")
  data
  |> result.unwrap("")
  |> part_2
  |> string.inspect
  |> io.println
}

pub fn part_1(lines: String) {
  lines
  |> string.split("\n")
  |> list.map(fn(x) {
    let [g, rest] =
      x
      |> string.split(": ")
    let [_, id] =
      g
      |> string.split(" ")
    let id =
      int.parse(id)
      |> result.unwrap(0)
    case
      rest
      |> string.split("; ")
      |> list.map(proc)
      |> list.all(fn(a) {
        let [r, g, b] = a
        r <= 12 && g <= 13 && b <= 14
      })
    {
      True -> id
      False -> 0
    }
  })
  |> int.sum
}

fn proc(l: String) -> List(Int) {
  let m =
    l
    |> string.split(", ")
    |> list.map(fn(x) {
      let [c, n] =
        x
        |> string.split(" ")
        |> list.reverse
      #(c, n)
    })
    |> dict.from_list
  [mget(m, "red"), mget(m, "green"), mget(m, "blue")]
}

fn mget(m: Dict(String, String), g: String) -> Int {
  m
  |> dict.get(g)
  |> result.map(int.parse)
  |> result.flatten
  |> result.unwrap(0)
}

pub fn part_2(lines: String) {
  lines
  |> string.split("\n")
  |> list.map(fn(x) {
    let [_, games] = string.split(x, ": ")
    let [rs, gs, bs] =
      games
      |> string.split("; ")
      |> list.map(proc)
      |> list.transpose
    max(rs) * max(gs) * max(bs)
  })
  |> int.sum
}

fn max(l: List(Int)) -> Int {
  l
  |> list.reduce(int.max)
  |> result.unwrap(1)
}
