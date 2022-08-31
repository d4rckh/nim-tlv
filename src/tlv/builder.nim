import std/endians

type
  Builder* = ref object
    buf*: seq[byte]

proc initBuilder*(): Builder =
  Builder()

proc addInt32*(builder: Builder, value: int32 = 0) =
  var int32bytes = cast[array[4, byte]](value)
  var leint32bytes: array[4, byte]

  littleEndian32(addr leint32bytes, addr int32bytes)
  for byt in leint32bytes: builder.buf.add byt

proc addChar*(builder: Builder, value: char) =
  let int32bytes = cast[array[1, byte]](value)
  
  for byt in int32bytes: builder.buf.add byt

proc addString*(builder: Builder, str: string) =
  builder.addInt32(cast[int32](len str))
  for chr in str: builder.addChar(chr)