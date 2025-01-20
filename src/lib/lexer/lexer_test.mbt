test "lexer" {
  let tokens = @lexer.tokenize("3 + (2 - 5) * 0")
  let result = @parser.start?(tokens, 0).unwrap()
  inspect!(result, content="3")
}
