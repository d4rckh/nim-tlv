import std/endians

type
  Builder* = ref object
    ## The main builder object. To intialize, call `initBuilder`
    buf*: seq[byte]

proc initBuilder*(): Builder =
  ## Initializes the builder
  Builder()

proc addInt32*(builder: Builder, value: int32 = 0) =
  ## Adds an int32 to the buffer
  var int32bytes = cast[array[4, byte]](value)
  var leint32bytes: array[4, byte]

  littleEndian32(addr leint32bytes, addr int32bytes)
  for byt in leint32bytes: builder.buf.add byt

proc addChar*(builder: Builder, value: char) =
  ## Adds a char to the buffer
  let charbyte = cast[byte](value)
  builder.buf.add charbyte
  
proc addString*(builder: Builder, str: string) =
  ## Adds an int32 (indicating the size of the string) and a string to the buffer
  builder.addInt32(cast[int32](len str))
  for chr in str: builder.addChar(chr)

proc addBool*(builder: Builder, boolean: bool) =
  ## Adds a 1 byte bool to the buffer
  let boolbyte = cast[byte](boolean)
  builder.buf.add boolbyte