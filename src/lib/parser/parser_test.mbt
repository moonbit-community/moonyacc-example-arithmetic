test "parser" {
  // let tokens = @lexer.tokenize("3 + (2 - 5) * 0")
  let tokens : Array[(@parser.Token, @parser.Position, @parser.Position)] = [
    (NUMBER(3), 0, 1),
    (PLUS, 1, 2),
    (LPAREN, 2, 3),
    (NUMBER(2), 3, 4),
    (MINUS, 4, 5),
    (NUMBER(5), 5, 6),
    (RPAREN, 6, 7),
    (STAR, 7, 8),
    (NUMBER(0), 8, 9),
    (EOF, 9, 9), // no EOF would result in a weird error
  ]
  let result = @parser.start?(tokens)
  inspect!(result, content="Ok(3)")
}
