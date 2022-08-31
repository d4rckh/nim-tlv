
type
  Parser* = ref object
    buf*: seq[byte]
    cursor*: int

proc initParser*(): Parser =
  Parser(cursor: 0)

proc setBuffer*(parser: Parser, buf: seq[byte]) =
  parser.buf = buf

proc extractInt32*(parser: Parser): int32 =
  result = (cast[ptr int32](addr parser.buf[parser.cursor]))[]
  parser.cursor += 4

proc extractChar*(parser: Parser): char =
  result = (cast[ptr char](addr parser.buf[parser.cursor]))[]
  parser.cursor += 1

proc extractString*(parser: Parser): string =
  let size = parser.extractInt32()
  var str = newStringOfCap(size)

  for _ in 0..(size - 1):
    str.add parser.extractChar()
  return str

proc extractBool*(parser: Parser): bool =
  result = (cast[ptr bool](addr parser.buf[parser.cursor]))[]
  parser.cursor += 1