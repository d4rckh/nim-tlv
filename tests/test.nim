# This is just an example to get you started. You may wish to put all of your
# tests into a single file, or separate them into multiple `test1`, `test2`
# etc. files (better names are recommended, just make sure the name starts with
# the letter 't').
#
# To run these tests, simply execute `nimble test`.

import unittest

import tlv/[builder, parser]

test "build and parse int32":
  var builder = initBuilder()
  builder.addInt32(500000)
  var parser = initParser()
  parser.setBuffer(builder.buf)

  check parser.extractInt32() == 500000

test "build and parse char":
  var builder = initBuilder()
  builder.addChar('A')
  var parser = initParser()
  parser.setBuffer(builder.buf)

  check parser.extractChar() == 'A'

test "build and parse string":
  var builder = initBuilder()
  builder.addString("hello world")
  var parser = initParser()
  parser.setBuffer(builder.buf)

  check parser.extractString() == "hello world"
