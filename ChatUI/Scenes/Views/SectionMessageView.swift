//
//  GroupMessageView.swift
//  ChatUI
//

import SwiftUI

struct SectionMessageView: View {
  let section: GroupMessage
  var body: some View {
    HStack {
      Text(section.dayText)
        .font(.headline.weight(.heavy))
      Text(section.timeText)
        .font(.headline)
    }
    .foregroundColor(.black)
    .padding()
  }
}

struct SectionMessageView_Previews: PreviewProvider {
  static var previews: some View {
    SectionMessageView(
      section: GroupMessage(
        originDate: .init(),
        dayText: "Today",
        timeText: "08:30",
        messages: []
      )
    )
    .previewLayout(.sizeThatFits)
  }
}
