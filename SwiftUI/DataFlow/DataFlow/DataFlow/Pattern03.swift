//
//  Pattern03.swift
//  DataFlow
//
//  Created by DJ Zhu on 2023/8/27.
//

import SwiftUI
import Combine

class  Pattern03_BookCount: ObservableObject {
  @Published var count: Int
  init(count: Int) {
    self.count = count
  }
}

struct Pattern03_SubSubView: View {
  @ObservedObject var bookCount: Pattern03_BookCount
  
  var body: some View {
    VStack {
      Text("Count: \(bookCount.count)")
        .font(.title3)
      Button("Update Count") {
        bookCount.count += 1
      }
    }
  }
}

class Pattern03_BookInfo: ObservableObject {
  @Published var bookTitle: String
  @Published var bookCount: Pattern03_BookCount
  init(bookTitle: String, bookCount: Pattern03_BookCount) {
    self.bookTitle = bookTitle
    self.bookCount = bookCount
  }
}

struct Pattern03_SubView: View {
  @ObservedObject var bookInfo: Pattern03_BookInfo
  
  var body: some View {
    VStack {
      Text("Title:\(bookInfo.bookTitle)")
        .font(.title2)
      Button("Update Title") {
        // update will cause the parent view to re-render
        bookInfo.bookTitle = "\(bookInfo.bookTitle)-\(Int.random(in: 1...10))"
      }
      Pattern03_SubSubView(bookCount: bookInfo.bookCount)
    }
  }
}

struct Pattern03_MainView: View  {
  // MainView itself won't co-op with it by the combine mechanism(like re-render automatically), so no need to use @ObservedObject wrapper
  var bookInfo: Pattern03_BookInfo
  
  var body: some View {
    VStack {
      Text("Book Info")
        .font(.title)
      Pattern03_SubView(bookInfo: bookInfo)
      Button("Log Whole Book Info") {
        // bootInfo hold the only truce of whole hirearchy, it can access all the properties
        print("Book Info, title: \(bookInfo.bookTitle), count: \(bookInfo.bookCount.count)")
      }
    }
  }
}

// previews
struct Pattern03_Previews: PreviewProvider {
  static var previews: some View {
    Pattern03_MainView(bookInfo: Pattern03_BookInfo(bookTitle: "SwiftUI handbook", bookCount: Pattern03_BookCount(count: 1)))
  }
}

