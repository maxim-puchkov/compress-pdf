import Cocoa

var str = "a" //Hello, playground"



func shift<T: Numeric>(_ param: inout T, _ n: T = 1) -> T {
  param = param + n
  return param
}
switch str {
case "-"...:
  print("-match : \(str)")
default:
  print("def")
}


var myint = 5
var int=15
shift(&int, 1)
shift(&myint, 1)
shift(&myint, 1)


var p1 = "/Users/admin/doc.pdf"
var p2 = "/Users/admin/doc.notpdf"
var u1 = URL(fileURLWithPath: p1, isDirectory: false)
var u2 = URL(fileURLWithPath: p2, isDirectory: false)
print(u1.deletePathExtension())
print(u2.deletingLastPathComponent())



/*
func printError(_ description: String,
                prefix: String = str) -> Bool {
  let err = FileHandle.standardError
  let errorText = "\(prefix): \(description)\n"
  guard let errorData = errorText.data(using: .utf8) else {
    return false
  }
  err.write(errorData)
  return true
}

print("OUT 1")
printError("text", prefix: "error")
print("OUT 2")
printError("", prefix: "error")
print("OUT 3")
printError("", prefix: "")
print("OUT 4")
printError("Text")
*/
