///|
fn main {
  let tokens = @lib.tokenize("3 + (2 - 5) * 0")
  let result = @lib.start?(tokens, 0).unwrap()
  println(result)
}
