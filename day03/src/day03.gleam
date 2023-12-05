import gleam/string
import simplifile
import gleam/io
import nibble/lexer.{type Span, type Token, Token}
import gleam/list

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

pub fn part_1(data: String) -> Int {
  let assert Ok(tokens) = lexer.run(data, lexer())
  let syms = list.filter(tokens, is_sym)
  use acc, sym <- list.fold(syms, 0)
  let assert Token(sp, _, _) = sym
  let nums =
    tokens
    |> list.filter(adjacent(sp))
  {
    use acc, t <- list.fold(nums, 0)
    let Token(_, _, Number(n)) = t
    n + acc
  } + acc
}

fn is_sym(tok) {
  case tok {
    Token(_, _, Symbol(_)) -> True
    _ -> False
  }
}

pub fn part_2(data: String) {
  let assert Ok(tokens) = lexer.run(data, lexer())
  let syms =
    tokens
    |> list.filter(is_sym)
  use acc, sym <- list.fold(syms, 0)
  let assert Token(sp, _, _) = sym
  let nums =
    tokens
    |> list.filter(adjacent(sp))
  case list.length(nums) {
    2 -> {
      use acc, t <- list.fold(nums, 1)
      let Token(_, _, Number(n)) = t
      n * acc
    }
    _ -> 0
  } + acc
}

pub type T {
  Symbol(inner: String)
  Number(inner: Int)
  Null
}

fn lexer() {
  lexer.simple([
    lexer.token("@", Symbol("@")),
    lexer.token("#", Symbol("#")),
    lexer.token("$", Symbol("$")),
    lexer.token("%", Symbol("%")),
    lexer.token("&", Symbol("&")),
    lexer.token("*", Symbol("*")),
    lexer.token("-", Symbol("-")),
    lexer.token("/", Symbol("/")),
    lexer.token("+", Symbol("+")),
    lexer.token("=", Symbol("=")),
    lexer.token("\"", Symbol("\"")),
    lexer.token("'", Symbol("'")),
    lexer.int(Number),
    lexer.token(".", Null)
    |> lexer.ignore,
    lexer.whitespace(Null)
    |> lexer.ignore,
  ])
}

fn adjacent(sym: Span) -> fn(Token(T)) -> Bool {
  fn(num: Token(T)) {
    case num {
      Token(num, _, Number(_)) ->
        { num.col_end >= sym.col_start && num.col_start <= sym.col_end } && {
          num.row_start >= { sym.row_start - 1 } && num.row_end <= {
            sym.row_end + 1
          }
        }
      _ -> False
    }
  }
}
