//
//  MessageView.swift
//  ChatUI
//

import SwiftUI

struct MessageView: View {
  let viewModel: MessageViewModel
  
  init(message: Message) {
    viewModel = .init(message: message)
  }
  var body: some View {
    HStack {
      if viewModel.message.own {
        Spacer()
      }
      VStack(alignment: .trailing, spacing: 2) {
        Text(viewModel.content)
          .modifier(
            MessageStyle(highlighted: viewModel.message.own)
          )
        if viewModel.message.own, let readedAt = viewModel.readedAt {
          Text(readedAt)
            .font(.footnote)
            .foregroundColor(.gray)
        }
      }
      if !viewModel.message.own {
        Spacer()
      }
    }
  }
}

struct MessageView_Previews: PreviewProvider {
  static var previews: some View {
    MessageView(
      message:
        Message(
          own: true,
          content: "Lorem Ipsum to you,\ntoo",
          sendedAt: Date(timeIntervalSinceNow: -3600),
          readedAt: Date(timeIntervalSinceNow: -1200)
        )
    )
    .previewLayout(.sizeThatFits)
    
    MessageView(
      message:
        Message(
          own: false,
          content: "Lorem Ipsum to you,\ntoo",
          sendedAt: Date(timeIntervalSinceNow: -3600),
          readedAt: Date(timeIntervalSinceNow: -1200)
        )
    )
    .previewLayout(.sizeThatFits)
  }
}
