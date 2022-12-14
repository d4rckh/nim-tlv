import unittest
import tlv

test "build and parse int32":
  var builder = initBuilder()
  builder.addInt32(500000)
  var parser = initParser(builder)

  check parser.extractInt32() == 500000

test "build and parse char":
  var builder = initBuilder()
  builder.addChar('A')
  var parser = initParser(builder)

  check parser.extractChar() == 'A'

test "build and parse string":
  var builder = initBuilder()
  builder.addString("hello world")
  var parser = initParser(builder)

  check parser.extractString() == "hello world"

test "build and parse boolean":
  var builder = initBuilder()
  builder.addBool(true)
  var parser = initParser(builder)

  check parser.extractBool() == true
