//
//  ChatViewModel.swift
//  ChatUI
//

import Foundation

final class ChatViewModel: ObservableObject {
  @Published var dataSource: [GroupMessage] = []
  private var messages: [Message] = []
  @Published var inputText = ""

  func add(dataManager: DataManager) {
    messages = dataManager.messages
    configureDataSource()
  }

  func createNewMessage(inputText: String) {
    let message: Message = .init(
      own: true,
      content: inputText,
      sendedAt: .init(),
      readedAt: nil
    )
    messages.append(message)
    configureDataSource()
    self.inputText = ""
  }

  // MARK: - Private

  private func configureDataSource() {
    let dictMessages: [Date: [Message]] = messages.reduce(into: [:]) { res, message in
      let components = Calendar.current.dateComponents([.year, .month, .day], from: message.sendedAt)
      let clearDate = Calendar.current.date(from: components)!
      let existing = res[clearDate] ?? []
      res[clearDate] = existing + [message]
    }
    dataSource = dictMessages.map { (date, messages) in
      let dayText: String
      if Calendar.current.isDateInToday(date) {
        dayText = "Today"
      } else if Calendar.current.isDateInYesterday(date) {
        dayText = "Yesterday"
      } else {
        let dayDateFormatter: DateFormatter = .init()
        dayDateFormatter.dateFormat = "MMMM dd"
        dayText = dayDateFormatter.string(from: date)
      }
      let timeDateFormatter: DateFormatter = .init()
      timeDateFormatter.dateFormat = "HH:mm"
      let timeText = timeDateFormatter.string(from: messages.first!.sendedAt)
      return .init(
        originDate: date,
        dayText: dayText,
        timeText: timeText,
        messages: messages
      )
    }.sorted(by: { lhs, rhs in
      return lhs.originDate.timeIntervalSinceReferenceDate < rhs.originDate.timeIntervalSinceReferenceDate
    })
  }

}
