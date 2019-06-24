import unittest

include qrcode

suite "slplit2":
  test "Even":
    check "12".split2 == @["12"]
    check "1234".split2 == @["12", "34"]
  test "Odd":
    check "1".split2 == @["1"]
    check "123".split2 == @["12", "3"]
  test "Empty":
    var empty: seq[string]
    check "".split2 == empty

suite "newQrCode":
  test "Normal":
    # check add(5, 5) == 10
    discard
