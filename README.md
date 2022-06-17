# Quick-Map

- There a list containg around 200,000 entries in JSON format.
- The list will be seperated and grouped by first prefix. The list is sorted in alphabetical order.
- This app display the information
  - A map with a search field.
  - The UI is responsive while typing.
  - The list is updated with every character changed the filter.
  - Tapping the cell will show the detail of the entries.
  - **Time efficiency for filter algorithm is better than linear**

## How to seperate and group

```swift
var cityDirectory: [Character:[City]] = [:]

// Put the city in `cityDirectory` with first prefix as a key
for city in cities {
    let prefix = Character(city.name.first!.lowercased())
    if !cityDirectory.keys.contains(prefix) {
        cityDirectory[prefix] = []
    }
    cityDirectory[prefix]?.append(city)
}

// Sorted in alphabetical order.
for (_, dict) in cityDirectory.enumerated() {
    cityDirectory[dict.key]!.sort{ $0.name.lowercased() < $1.name.lowercased() }
}
let sortedCityDirectory = cityDirectory.sorted{ $0.key < $1.key }

// Export
for directory in sortedCityDirectory {
    try JSONEncoder()
        .encode(directory.value)
        .write(to: cityOutputURL.appendingPathComponent("\(directory.key).json"))
}
```

## Search the matched prefix

- Use the binary search technique
  - Find lowest and largest indices (Range)

```swift
/// Search the **lowest** index of citiy that has a specifix prefix
///
/// Time complexity: O(logn)
private func bsearchLowestIndex(for prefix: String) -> Int? {
    let lowercasedPrefix = prefix.lowercased()
    var candidateSolution: Int? = nil
    var start = 0
    var end = letterSortedCity.count - 1
    let prefixLength = lowercasedPrefix.count
    while start <= end {
        let mid = (start + end) / 2
        let midValue = letterSortedCity[mid]
        let midCityNamePrefix = midValue.name.prefix(prefixLength)
        let result = midCityNamePrefix
            .lowercased()
            .compare(lowercasedPrefix)
            .rawValue
        if result == 0 {
            candidateSolution = mid
            end = mid - 1
        } else if result > 0 {
            end = mid - 1
        } else {
            start = mid + 1
        }
    }
    return candidateSolution
}
```
