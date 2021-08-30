//
//  Message.swift
//  ChatUI
//

import Foundation

struct Message: Codable, Identifiable {
  let id: UUID = .init()
  let own: Bool
  let content: String
  let sendedAt: Date
  let readedAt: Date?

  enum CodingKey: String {
    case own = "own"
    case content = "content"
    case sendedAt = "sendedAt"
    case readedAt = "readedAt"
  }
}
