import simplifile
import gleam/io
import gleam/string
import gleam/pair
import gleam/list
import gleam/dict
import gleam/iterator
import gleam/int
import gleam/result
import gleam_community/maths/arithmetics

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

type Defs =
  dict.Dict(String, #(String, String))

type Instructions =
  iterator.Iterator(#(Int, fn(#(String, String)) -> String))

fn parse_instructions(s: String) -> Instructions {
  s
  |> string.to_graphemes
  |> list.map(fn(x) {
    case x {
      "L" -> pair.first
      "R" -> pair.second
      _ -> panic as "Unrecognised instruction"
    }
  })
  |> iterator.from_list
  |> iterator.cycle
  |> iterator.index
}

fn parse_defs(s: List(String)) -> Defs {
  s
  |> list.map(fn(x) {
    let [k, vs] =
      x
      |> string.split(" = ")
    let [v1, v2] =
      vs
      |> string.replace("(", "")
      |> string.replace(")", "")
      |> string.split(", ")
    #(k, #(v1, v2))
  })
  |> dict.from_list
}

fn find_soln_1(instructions: Instructions, defs: Defs) -> Int {
  instructions
  |> iterator.fold_until(
    "AAA",
    fn(acc, x) {
      let #(idx, x) = x
      let assert Ok(opts) = dict.get(defs, acc)
      let new_dest =
        opts
        |> x
      case new_dest {
        "ZZZ" -> list.Stop(int.to_string(idx + 1))
        _ -> list.Continue(new_dest)
      }
    },
  )
  |> int.parse
  |> result.unwrap(-1)
}

pub fn part_1(lines: String) {
  let [h, _, ..t] =
    lines
    |> string.split("\n")
  let instructions = parse_instructions(h)
  let defs = parse_defs(t)
  find_soln_1(instructions, defs)
}

fn find_soln_2(start: String, instructions: Instructions, defs: Defs) -> Int {
  instructions
  |> iterator.fold_until(
    start,
    fn(acc, x) {
      let #(idx, x) = x
      let assert Ok(opts) = dict.get(defs, acc)
      let new_dest =
        opts
        |> x
      case string.ends_with(new_dest, "Z") {
        True -> list.Stop(int.to_string(idx + 1))
        False -> list.Continue(new_dest)
      }
    },
  )
  |> int.parse
  |> result.unwrap(-1)
}

pub fn part_2(lines: String) {
  let [h, _, ..t] =
    lines
    |> string.split("\n")
  let instructions = parse_instructions(h)
  let defs = parse_defs(t)
  let possible_starts = dict.keys(defs)
  let assert Ok(res) =
    possible_starts
    |> list.filter_map(fn(x) {
      let x = string.reverse(x)
      case x {
        "A" <> rs -> Ok(string.reverse(rs) <> "A")
        _ -> Error(Nil)
      }
    })
    |> list.map(find_soln_2(_, instructions, defs))
    |> list.reduce(arithmetics.lcm)
  res
}
