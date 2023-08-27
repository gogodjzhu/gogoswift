//
//  DataFlowApp.swift
//  DataFlow
//
//  Created by DJ Zhu on 2023/8/27.
//

import SwiftUI

@main
struct DataFlowApp: App {
  var body: some Scene {
    WindowGroup {
      Pattern03_MainView(bookInfo: Pattern03_BookInfo(bookTitle: "SwiftUI handbook", bookCount: Pattern03_BookCount(count: 1)))
    }
  }
}
