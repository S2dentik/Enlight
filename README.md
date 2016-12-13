# Enlight
A framework and Xcode plugin for generating Lenses using SourceKitten

Just give it the model files and it will generate `Simple Lens`es based on that:

### Example:

```swift
struct Model {
  let string: String
  let int: Int
}
```

### Output:

```swift
extension Model {
  static let stringLens: Lens<Model, String> {
    return Lens<Model, String>(
      get: { $0.string },
      set: { Model(string: $0, int: $1.int) }
    )
  }
  
  static let stringLens: Lens<Model, Int> {
    return Lens<Model, Int>(
      get: { $0.int },
      set: { Model(string: $1.string, int: $0) }
    )
  }
}
```
