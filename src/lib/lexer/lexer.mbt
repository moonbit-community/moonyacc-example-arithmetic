///|
priv suberror EndOfInput

///|
pub fn tokenize(
  input : String
) -> Array[(@parser.Token, Int, Int)] {
  let tokens : Array[(@parser.Token, Int, Int)] = []
  let end = input.length()
  let mut cursor = 0
  fn peek_char() raise {
    guard cursor < end else { raise EndOfInput }
    input.get_char(cursor).unwrap()
  }

  fn advance() {
    cursor += 1
  }

  letrec read_number = fn(first_char : Char) raise {
    let buf = StringBuilder::new()
    buf.write_char(first_char)
    while true {
      match (try? peek_char()) {
        Ok('0'..='9' as c) => {
          buf.write_char(c)
          advance()
        }
        Ok(_) | Err(EndOfInput) => break
        Err(err) => raise err
      }
    }
    @strconv.parse_int(buf.to_string())
  }

  fn read_token() -> (@parser.Token, Int, Int) raise {
    let start = cursor
    match peek_char() {
      '0'..='9' as c => {
        advance()
        let num = read_number(c)
        (NUMBER(num), start, cursor)
      }
      '+' => {
        advance()
        (PLUS, start, cursor)
      }
      '-' => {
        advance()
        (MINUS, start, cursor)
      }
      '*' => {
        advance()
        (STAR, start, cursor)
      }
      '(' => {
        advance()
        (LPAREN, start, cursor)
      }
      ')' => {
        advance()
        (RPAREN, start, cursor)
      }
      ' ' | '\t' | '\r' | '\n' => {
        advance()
        read_token()
      }
      _ => panic()
    }
  }

  while true {
    try read_token() catch {
      EndOfInput => break
      _ => panic()
    } else {
      token => tokens.push(token)
    }
  }
  tokens
}
