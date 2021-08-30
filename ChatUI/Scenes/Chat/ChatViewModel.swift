//
//  ChatViewModel.swift
//  ChatUI
//

import Foundation
import Combine

final class ChatViewModel: ObservableObject {
  @Published var dataSource: [GroupMessage] = []
  private var messages: [Message] = []
  private var currentIndexPage: Int = 1
  private var pageMessages = 10
  @Published var inputText = ""
  var isEnabledSendButton: Bool = false
  var cancellable: Set<AnyCancellable> = []

  init() {
    setupObservers()
  }

  func add(dataManager: DataManager) {
    messages = dataManager.messages
    loadMore()
  }

  func createNewMessage(inputText: String) {
    let message: Message = .init(
      own: true,
      content: inputText,
      sendedAt: .init(),
      readedAt: nil
    )
    messages.append(message)
    loadMore()
    self.inputText = ""
  }

  func loadMore() {
    let countOfMessages = min(0, messages.count - pageMessages * currentIndexPage)
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
      return lhs.originDate < rhs.originDate
    })
    currentIndexPage += 1
  }

  func setupObservers() {
    $inputText
      .receive(on: DispatchQueue.main)
      .sink { [weak self] value in
        self?.isEnabledSendButton = !value.isEmpty
      }
      .store(in: &cancellable)
  }
}
