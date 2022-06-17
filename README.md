# Quick-Map

- There is a [list](unsorted_cities.json) containing around 200,000 entries in JSON format.
- The list will be separated and grouped by the first prefix. The list is sorted in alphabetical order.
- This app displays the information
  - A map with a search field.
  - The UI is responsive while typing.
  - The list is updated with every character changed in the filter.
  - Tapping the cell will show the location of the entries.
  - **Time efficiency for filter algorithm is better than linear**

## Development Info

- Xcode Version 13.4.1 (13F100)
- iOS 14

## Demo

![Demo](demo.gif)

## How to seperate and group

- The [list](unsorted_cities.json) is converted to `[City]` into `cities`

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
