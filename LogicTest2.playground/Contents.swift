
// Complexity: O(n)


func validatePalindrome(string: String) -> Bool {
    var stringLength = 0
    var stringArray: [String] = []
    for character in string {
        /// since the Example is Insensitive Compare
        stringArray.append(String(character).lowercased())
        /// count Character because
        stringLength += 1
    }
    /// Since an Empty string and Single character string reads the same forward and backward, it is a palindrome.
    if stringLength < 2 {
        return true
    }
    for index in 0..<(stringLength / 2) {
        if stringArray[index] != stringArray[stringLength - 1 - index] {
            return false
        }
    }
    return true
}

func getResult(string: String) -> String {
    return validatePalindrome(string: string) ? "\(string) is a palindrome" : "\(string) isn’t a palindrome"
}

let inputs: [String] = [
    "",
    "a",
    "aa",
    "aKa",
    "aka",
    "akkA",
    "Level",
    "Levle"
]

inputs.forEach {
    print(getResult(string: $0))
}
