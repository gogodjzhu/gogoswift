# Data Flow & State in SwiftUI
SwiftUI is a modern framework for building user interfaces in iOS, macOS, watchOS, and tvOS apps. One of its key features is the declarative syntax that allows developers to describe the UI in a simple and intuitive way. However, building a complex app with dynamic data requires managing the state of the app and the flow of data between the views. In this article, we'll explore the different ways to manage the data flow and state in SwiftUI, including the use of @State, @Binding, @ObservedObject, and @EnvironmentObject. We'll also cover how to handle nested objects and collections mutations, and how to adapt your data model to work seamlessly with SwiftUI.

## @State, @Binding
They are two of the very basic wrappers that SwiftUI provides to manage the state of the app. `@State` is used to marked a property as a *source of truce* which is create and owned by the view itself. By marked a `@Binding` property out of origin view, we can create a two-way connection between the source of truth and the view that needs to use it. Any mutation to the `@State` property in the parent view will cause child view that holds the related `@Binding` property to be re-rendered, vice versa. Here is a very simple example you must familiar with:

```swift
import SwiftUI

struct Pattern01_SubView: View {
  @Binding var bookTitle: String
  
  var body: some View {
    VStack {
      Button("Update Title") {
        // update will cause the parent view to re-render
        bookTitle = "\(bookTitle)-\(Int.random(in: 1...10))"
      }
    }
  }
}

struct Pattern01_MainView: View  {
  @State var bookTitle: String
  
  var body: some View {
    VStack {
      Text("Book Title: \(bookTitle)")
      Pattern01_SubView(bookTitle: $bookTitle)
    }
  }
}

// previews
struct Pattern01_Previews: PreviewProvider {
  static var previews: some View {
    Pattern01_MainView(bookTitle: .init("SwiftUI handbook"))
  }
}
```

However, there is a critical limitation of `@State` and `@Binding` that you should be aware of. They are only designed to work with simple data types. SwiftUI not monitor the changes of a reference type like `class` or `struct`.

## @ObservedObject, @EnvironmentObject
The `@ObservedObject` and `@EnvironmentObject` are designed to work with reference types.

## Nested Objects and Collections mutations

### Update with didSet

### Adapt data model to SwiftUI