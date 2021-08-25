//
//  DataManager.swift
//  ChatUI
//
//  Created by Bogdan Petkanich on 8/24/21.
//

import Foundation

class DataManager: ObservableObject {

  @Published var messages: [Message] = []

  init() {
    messages = loadData()
  }

}

private extension DataManager {

  func loadData() -> [Message] {
    guard
      let urlToData = Bundle.main.url(forResource: "resource", withExtension: "json"),
      let data = try? Data(contentsOf: urlToData)
    else {
      return []
    }
    let decoder = JSONDecoder()
    let messages = try? decoder.decode([Message].self, from: data)
    return messages ?? []
  }

}
