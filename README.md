# nim-tlv
simplified tlv building and parsing in nim

## examples

### simple values

```nim
import tlv

var b = initBuilder()

b.addInt32(10)
b.addChar('A')
b.addString("hello world")
b.addBool(true)

echo b.buf

var p = initParser()
p.setBuffer(b.buf)

echo p.extractInt32() # => 10
echo p.extractChar() # => A
echo p.extractString() # => hello world
echo p.extractBool() # => true
```

### arrays

```nim
import tlv

var b = initBuilder()

### build the array

proc addUser*(b: Builder, username: string, age: int32) =
  b.addInt32(age)
  b.addString(username)

# set the length of the array
b.addInt32(5)

# add each user
b.addUser("user1", 30)
b.addUser("user2", 20)
b.addUser("user3", 21)
b.addUser("user4", 19)
b.addUser("user5", 27)

### parse the array

var p = initParser()
p.setBuffer(b.buf)

type User = object
  username: string
  age: int32

proc extractUser*(parser: Parser): User =
  result.age = parser.extractInt32()
  result.username = parser.extractString()

let usersLen = p.extractInt32()
var users = newSeqOfCap[User](usersLen)

for _ in 1..(usersLen):
  users.add(p.extractUser())

for user in users:
  echo "username: " & user.username & "; age: " & $user.age
```