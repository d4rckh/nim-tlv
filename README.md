# nim-tlv
tlv building and parsing in nim

## example

```nim
import tlv/[builder, parser]

var b = initBuilder()

b.addInt32(10)
b.addChar('A')
b.addString("hello world")

echo b.buf

var p = initParser()
p.setBuffer(b.buf)

echo p.extractInt32() # => 10
echo p.extractChar() # => A
echo p.extractString() # => hello world
```
