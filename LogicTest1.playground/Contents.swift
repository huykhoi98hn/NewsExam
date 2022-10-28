

// Complexity: O(n)
func findMiddleIndex(array: [Int]) -> Int? {
    /// If Array have 1 element => Middle Index is 0
    if array.count == 1 {
        return 0
    }
    /// Array of sum Left, start with 0
    var sumLeftArray: [Int] = array.enumerated().reduce([0]) { partialResult, enumerate in
        return partialResult + [enumerate.element + partialResult[enumerate.offset]]
    }
    /// If Array have 0 or 2 element => No middle index
    /// Remove last sumLeft element, Equal to total value of array
    guard array.count > 2, let totalValue = sumLeftArray.popLast() else {
        return nil
    }
    for (index, sumLeftElement) in sumLeftArray.enumerated() {
        /// sumLeftElement == sumRightElement <=> totalValue - leftElement  == 2 * sumLeftElement
        if totalValue - array[index] == sumLeftElement * 2 {
            return index
        }
    }
    return nil
}

func getResult(array: [Int]) -> String {
    if let index = findMiddleIndex(array: array) {
        return "middle index is \(index)"
    }
    return "index not found"
}

let arrays: [[Int]] = [
    [],
    [5],
    [1, 3],
    [2, 2, 2],
    [3, 5, 6],
    [2, 0, 0, 2],
    [1, 3, 5, 7, 9],
    [1, -3, -5, 7, -7],
    [4, 7, 8, 1, 5, 10, 2, 8]
]

arrays.forEach {
    print(getResult(array: $0))
}
