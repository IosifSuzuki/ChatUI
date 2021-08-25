//
//  Message.swift
//  ChatUI
//

import Foundation

struct Message: Codable {
  let own: Bool
  let content: String
  let sendedAt: Date
  let readedAt: Date?
}
