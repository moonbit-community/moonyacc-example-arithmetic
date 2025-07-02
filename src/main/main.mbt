///|
fn main {
  let tokens = @lexer.tokenize("3 + (2 - 5) * 0")
  let result = (try? @parser.start(tokens)).unwrap()
  println(result)
}
