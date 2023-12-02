import gleam/int
import gleam/string
import gleam/result
import gleam/list
import gleam/io
import gleam/dict.{type Dict}
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
    let assert Ok(id) = int.parse(id)
    case
      rest
      |> string.split("; ")
      |> list.map(proc)
      |> list.all(fn(a) {
        let [r, g, b] = a
        r <= 12 && g <= 13 && b <= 14
      })
    {
      // If the colors are within bounds, return id for summing
      // Otherwise, return 0 so sum doesnt change
      True -> id
      False -> 0
    }
  })
  |> int.sum
}

// Process one game string into a list of ints [r,g,b]
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
  // If a color isn't present, we want to set it to 0
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
    // Transpose to turn out list of [[r1,g1,b1],[r2,g2,b2]...] into
    // [[r1,r2,...],[g1,g2,...],[b1,b2,...]] so we can run max
    max(rs) * max(gs) * max(bs)
  })
  |> int.sum
}

// Helper function to find the max int in a list
// This should really be in the stdlib...
fn max(l: List(Int)) -> Int {
  let assert Ok(l) =
    l
    |> list.reduce(int.max)
  l
}
