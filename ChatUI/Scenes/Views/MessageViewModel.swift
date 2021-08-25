//
//  MessageViewModel.swift
//  ChatUI
//

import Foundation

class MessageViewModel: ObservableObject {
  @Published var readedAt: String?
  @Published var content: String

  let message: Message

  init(message: Message) {
    self.message = message
    content = message.content.capitalized
    if let readedAt = message.readedAt {
      self.readedAt(readedAt)
    }
  }

  func readedAt(_ readedAt: Date) {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "HH:mm"
    self.readedAt = String(format: "Read %@", dateFormatter.string(from: readedAt))
  }

}
