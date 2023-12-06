import gleam/string
import simplifile
import gleam/io
import gleam/list
import gleam/result
import gleam/int
import gleam/float
// import gleamy/bench

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
  // bench.run(
  //   [bench.Input("data", result.unwrap(simplifile.read("./data.txt"), ""))],
  //   [bench.Function("Part 1", part_1), bench.Function("Part 2", part_2)],
  //   [bench.Duration(1000), bench.Warmup(100)],
  // )
  // |> bench.table([bench.Mean, bench.Min, bench.Max])
  // |> io.println()
}

pub type Race {
  Race(time: Int, record: Int)
}

pub fn part_1(data: String) {
  use acc, x <- list.fold(parse_1(data), 1)
  acc * find_wins(x)
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

fn find_wins(r: Race) {
  let a = -1.0
  let b = int.to_float(r.time)
  let c = int.to_float(-r.record)
  let assert Ok(b2) = float.power(b, 2.0)
  let assert Ok(sqrt) = float.square_root(b2 -. { 4.0 *. a *. c })
  let r =
    float.ceiling({ 0.0 -. b -. sqrt } /. { 2.0 *. a }) -. float.floor(
      { 0.0 -. b +. sqrt } /. { 2.0 *. a },
    )
  float.truncate(r -. 1.0)
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
      |> list.filter(fn(y) { y != " " })
      |> string.join("")
      |> int.parse
      |> result.unwrap(0)
    })
  Race(t, d)
}
