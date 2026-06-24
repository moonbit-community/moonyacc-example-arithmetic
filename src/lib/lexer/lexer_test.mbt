///|
test "lexer" {
  let tokens = @lexer.tokenize("3 + (2 - 5) * 0")
  assert_eq(@parser.start(tokens), 3)
}
