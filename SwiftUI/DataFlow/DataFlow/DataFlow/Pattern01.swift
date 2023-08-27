//
//  Pattern01.swift
//  DataFlow
//
//  Created by DJ Zhu on 2023/8/27.
//

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

