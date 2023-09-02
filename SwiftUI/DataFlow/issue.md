# Data Flow & State in SwiftUI

why does Sheet cannot show correct values in first time 

```swift
import SwiftUI

@main
struct gogodictApp: App {
  var body: some Scene {
    WindowGroup {
      MyView()
    }
  }
}

struct MyView: View {
  @State private var search: String = ""
  @State private var showSheet: Bool = false
  @State private var randomInt: Int?
  var body: some View {
    
    VStack {
      TextField("Input...", text: $search){
      }
      .onSubmit {
        self.randomInt = Int.random(in: 1...10)
        print("set randomInt = \(self.randomInt ?? -1)") // see this every submit even first time
        showSheet.toggle()
      }
      .sheet(isPresented: $showSheet) {
        Text("get randomInt = \(self.randomInt ?? -1)") // only see this after first submit
      }
    }
  }
}
```

## solutions
### solution 1. add `onChange()` to `TextField`
```swift
TextField()
//...
.onChange(of: randomInt) {_ in} // add this
```
> The reason why this solution will work?
### solution 2. use `sheet(item:onDismiss:content:)` instead of `sheet(isPresented:content:)`
```swift
TextField()
//...
.sheet(item: $randomInt) { randomInt in
  Text("get randomInt = \(self.randomInt ?? -1)") // only see this after first submit
}
.sheet
```
> The reason why this solution will work?

## related articles
[@StateObject 和 @ObservedObject 的区别和使用](https://onevcat.com/2020/06/stateobject/)
[手写一个@State](https://www.jianshu.com/p/d6443da77f3e)


## related unfinished stackoverflow question
[SwiftUI: Sheet cannot show correct values in first time](https://stackoverflow.com/questions/64798211/swiftui-sheet-cannot-show-correct-values-in-first-time)
[State property isn't updated quickly enough](https://forums.swift.org/t/state-property-isnt-updated-quickly-enough/59625)
