# Enlight
A framework and Xcode plugin for generating Lenses using SourceKitten

Just give it the model files and it will generate `Simple Lens`es based on that:

### Example:

```swift
struct Model {
  let string: String
  let int: Int
  let float: Float
  let double: Double
  let array: [Any]
  let dictionary: [String: Any]
}

```

### Output:

```swift
extension Model {
  static let stringLens = Lens<Model, String>(
    get: { $0.string },
    set: { Model(string: $0, int: $1.int, float: $1.float, double: $1.double, array: $1.array, dictionary: $1.dictionary) }
  )

  static let intLens = Lens<Model, Int>(
    get: { $0.int },
    set: { Model(string: $1.string, int: $0, float: $1.float, double: $1.double, array: $1.array, dictionary: $1.dictionary) }
  )

  static let floatLens = Lens<Model, Float>(
    get: { $0.float },
    set: { Model(string: $1.string, int: $1.int, float: $0, double: $1.double, array: $1.array, dictionary: $1.dictionary) }
  )

  static let doubleLens = Lens<Model, Double>(
    get: { $0.double },
    set: { Model(string: $1.string, int: $1.int, float: $1.float, double: $0, array: $1.array, dictionary: $1.dictionary) }
  )

  static let arrayLens = Lens<Model, [Any]>(
    get: { $0.array },
    set: { Model(string: $1.string, int: $1.int, float: $1.float, double: $1.double, array: $0, dictionary: $1.dictionary) }
  )

  static let dictionaryLens = Lens<Model, [String: Any]>(
    get: { $0.dictionary },
    set: { Model(string: $1.string, int: $1.int, float: $1.float, double: $1.double, array: $1.array, dictionary: $0) }
  )
}
```
