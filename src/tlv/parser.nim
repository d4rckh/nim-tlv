import builder

type
  Parser* = ref object
    ## The main parser object. \
    ## To initialize, call `initParser` and then `setBuffer`
    buf: seq[byte] ## Stores the buffer to be parsed
    cursor: int ## Stores the current position from which future values will be read

proc initParser*(): Parser =
  ## Initializes the parser
  Parser(cursor: 0)

proc initParser*(builder: Builder): Parser =
  ## Initializes the parser using a builder's buf
  Parser(cursor: 0, buf: builder.buf)

proc setBuffer*(parser: Parser, buf: seq[byte]) =
  ## Sets the parser buffer and resets the cursor to 0
  parser.buf = buf
  parser.cursor = 0

proc getCursor*(parser: Parser): int =
  ## Returns the parser's cursor
  parser.cursor

proc extractInt32*(parser: Parser): int32 =
  ## Extracts the next int32 from the cursor's position
  result = (cast[ptr int32](addr parser.buf[parser.cursor]))[]
  parser.cursor += 4

proc extractChar*(parser: Parser): char =
  ## Extracts the next char from the cursor's position
  result = (cast[ptr char](addr parser.buf[parser.cursor]))[]
  parser.cursor += 1

proc extractString*(parser: Parser): string =
  ## Extracts a string from the cursor's position
  let size = parser.extractInt32()
  var str = newStringOfCap(size)

  for _ in 0..(size - 1):
    str.add parser.extractChar()
  return str

proc extractBool*(parser: Parser): bool =
  ## Extracts a bool from the cursor's position
  result = (cast[ptr bool](addr parser.buf[parser.cursor]))[]
  parser.cursor += 1