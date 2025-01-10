///|
type! EndOfInput

///|
pub fn tokenize(input : String) -> () -> (Token, Position, Position) {
  let end = input.length()
  let mut cursor = 0
  fn peek_char!() {
    guard cursor < end else { raise EndOfInput }
    input[cursor]
  }

  fn advance() {
    cursor += 1
  }

  fn read_token() {
    let start = cursor
    try {
      match peek_char!() {
        '0'..='9' as c => {
          advance()
          let num = read_number!(c)
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
    } catch {
      EndOfInput => return (EOF, end, end)
      _ => panic()
    }
  }

  fn read_number!(first_char : Char) {
    let buf = StringBuilder::new()
    buf.write_char(first_char)
    while true {
      match peek_char?() {
        Ok('0'..='9' as c) => {
          buf.write_char(c)
          advance()
        }
        Ok(_) | Err(EndOfInput) => break
        Err(err) => raise err
      }
    }
    @strconv.parse_int!(buf.to_string())
  }

  read_token
}
