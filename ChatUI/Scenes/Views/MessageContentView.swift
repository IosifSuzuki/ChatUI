//
//  MessageView.swift
//  ChatUI
//

import SwiftUI

struct MessageStyle: ViewModifier {
  let highlighted: Bool

  func body(content: Content) -> some View {
    content
      .foregroundColor(highlighted ? .white : .white.opacity(0.75))
      .lineLimit(nil)
      .padding()
      .background(
        RoundedRectangle(
          cornerRadius: 16
        )
        .fill(highlighted ? Color.blue : Color.black.opacity(0.75))
      )
      .font(.body)
  }

}

struct MessageContentView_Previews: PreviewProvider {
  static var previews: some View {
    Text("Hi! Lorem Ipsum")
      .modifier(
        MessageStyle(highlighted: true)
      )
      .previewLayout(.sizeThatFits)

    Text("Lorem Ipsum to you,\ntoo")
      .modifier(
        MessageStyle(highlighted: false)
      )
      .previewLayout(.sizeThatFits)
  }
}
