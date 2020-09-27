import Cocoa

var str = "Hello, playground"


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
