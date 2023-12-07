import simplifile
import gleam/io
import gleam/string
import day07_1
import day07_2

pub fn main() {
  let assert Ok(data) = simplifile.read("./data.txt")
  io.println("Part 1:")
  data
  |> day07_1.part_1
  |> string.inspect
  |> io.println
  io.println("Part 2:")
  data
  |> day07_2.part_2
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
