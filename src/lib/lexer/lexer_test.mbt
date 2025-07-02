///|
test "lexer" {
  let tokens = @lexer.tokenize("3 + (2 - 5) * 0")
  let result = try? @parser.start(tokens)
  inspect(result, content="Ok(3)")
}
