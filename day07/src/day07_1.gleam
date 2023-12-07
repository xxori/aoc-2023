import gleam/string
import gleam/list
import gleam/int
import gleam/result
import gleam/order.{type Order}
import gleam/pair

pub type Play {
  Play(hand: Hand, bid: Int)
}

pub type Hand =
  #(HandType, List(Card))

pub type HandType {
  FiveKind
  FourKind
  FullHouse
  ThreeKind
  TwoPair
  OnePair
  HighCard
}

pub type Card {
  A
  K
  Q
  J
  T
  Dec(val: Int)
}

pub fn htype_to_int(v: HandType) -> Int {
  case v {
    FiveKind -> 7
    FourKind -> 6
    FullHouse -> 5
    ThreeKind -> 4
    TwoPair -> 3
    OnePair -> 2
    HighCard -> 1
  }
}

fn parse_card(c: String) -> Card {
  case c {
    "A" -> A
    "K" -> K
    "Q" -> Q
    "J" -> J
    "T" -> T
    v -> Dec(result.unwrap(int.parse(v), 0))
  }
}

pub fn card_to_int(c: Card) -> Int {
  case c {
    A -> 14
    K -> 13
    Q -> 12
    J -> 11
    T -> 10
    Dec(v) -> v
  }
}

pub fn compare_plays(v1: Play, v2: Play) -> Order {
  let #(t1, h1) = v1.hand
  let #(t2, h2) = v2.hand
  case int.compare(htype_to_int(t1), htype_to_int(t2)) {
    order.Eq -> {
      let assert Ok(r) =
        list.zip(h1, h2)
        |> list.map(fn(x) {
          let #(c1, c2) = x
          compare_cards(c1, c2)
        })
        |> list.find(fn(x) { x != order.Eq })
      r
    }
    t -> t
  }
}

fn find_handtype(hand: List(Card)) -> HandType {
  let u = list.unique(hand)
  let freqs =
    u
    |> list.map(fn(card) {
      use acc, x <- list.fold(hand, 0)
      case card_to_int(card) == card_to_int(x) {
        True -> acc + 1
        False -> acc
      }
    })
  case
    list.zip(u, freqs)
    |> list.sort(fn(x, y) { int.compare(pair.second(y), pair.second(x)) })
  {
    [#(_, 5)] -> FiveKind
    [#(_, 4), _] -> FourKind
    [#(_, 3), #(_, 2)] -> FullHouse
    [#(_, 3), ..] -> ThreeKind
    [#(_, 2), #(_, 2), _] -> TwoPair
    [#(_, 2), ..] -> OnePair
    _ -> HighCard
  }
}

pub fn compare_cards(c1: Card, c2: Card) -> Order {
  int.compare(card_to_int(c1), card_to_int(c2))
}

fn parse_play(input: String) -> Play {
  let [hand, bid] = string.split(input, " ")
  let assert Ok(bid) = int.parse(bid)
  let cards =
    hand
    |> string.to_graphemes
    |> list.map(parse_card)
  let handtype = find_handtype(cards)
  Play(#(handtype, cards), bid)
}

pub fn part_1(lines: String) {
  use acc, x, idx <- list.index_fold(
    lines
    |> string.split("\n")
    |> list.map(parse_play)
    |> list.sort(compare_plays),
    0,
  )
  let rank = idx + 1
  acc + { rank * x.bid }
}
