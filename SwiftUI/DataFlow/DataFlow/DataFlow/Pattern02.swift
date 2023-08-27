//
//  Pattern02.swift
//  DataFlow
//
//  Created by DJ Zhu on 2023/8/27.
//

import SwiftUI
import Combine

class  Pattern02_BookCount: ObservableObject {
  @Published var count: Int
  init(bookCount: Int) {
    self.count = bookCount
  }
}

class Pattern02_BookInfo: ObservableObject {
  @Published var bookTitle: String
  @Published var bookCount: Pattern02_BookCount
  init(bookTitle: String, bookCount: Pattern02_BookCount) {
    self.bookTitle = bookTitle
    self.bookCount = bookCount
  }
}

struct Pattern02_SubView: View {
  @EnvironmentObject var bookInfo: Pattern02_BookInfo
  
  var body: some View {
    VStack {
      Button("Update Title") {
        // update will cause the parent view to re-render
        bookInfo.bookTitle = "\(bookInfo.bookTitle)-\(Int.random(in: 1...10))"
      }
      Button("Update Count") {
        // update will NOT cause the parent view to re-render
        // because the `@EnvironmentObject` will only subscribe to the `@Published` property itself,
        // any change to its property will not be notified to the parent view
        bookInfo.bookCount.count += 1
      }
    }
  }
}

struct Pattern02_MainView: View  {
  @EnvironmentObject var bookInfo: Pattern02_BookInfo
  
  var body: some View {
    VStack {
      Text("Book Title: \(bookInfo.bookTitle), Count: \(bookInfo.bookCount.count)")
      Pattern02_SubView()
    }
  }
}

// previews
struct Pattern02_Previews: PreviewProvider {
  static var previews: some View {
    Pattern02_MainView()
      // inject the environment object for whole view hierarchy
      .environmentObject(Pattern02_BookInfo(bookTitle: "SwiftUI handbook", bookCount: Pattern02_BookCount(bookCount: 1)))
  }
}

