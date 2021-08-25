//
//  InputTextView.swift
//  ChatUI
//

import SwiftUI

struct InputTextView: View {
  typealias SendTextAction = (String) -> Void
  typealias AddAtachmentAction = () -> Void
  
  private let placeholder: String
  private let sendTextAction: SendTextAction?
  private let addAtachmentAction: AddAtachmentAction?
  @Binding var inputText: String
  @State private var textViewHeight: CGFloat = 0
  
  init(
    text: Binding<String>,
    placeholder: String,
    sendTextAction: SendTextAction? = nil,
    addAtachmentAction: AddAtachmentAction? = nil
  ) {
    _inputText = text
    self.placeholder = placeholder
    self.sendTextAction = sendTextAction
    self.addAtachmentAction = addAtachmentAction
  }
  
  var body: some View {
    HStack(alignment: .top, spacing: 0) {
      Button(action: {
        
      }, label: {
        Image(systemName: "plus")
          .font(.body.bold())
          .frame(width: 30, height: 30)
          .foregroundColor(.white)
          .background(
            RoundedRectangle(
              cornerRadius: 15
            )
            .fill(Color.gray)
          )
      })
      .padding(5)
      HStack(alignment: .top, spacing: 0) {
        DynamicTextView(
          placeholder: placeholder,
          textContainerInset: .init(top: 10, left: 15, bottom: 10, right: 0),
          font: .systemFont(ofSize: 16),
          textColor: .white,
          text: $inputText,
          height: $textViewHeight
        )
        Button(action: {
          sendTextAction?(inputText)
        }, label: {
          Image(systemName: "arrow.up")
            .font(.body.bold())
            .frame(width: 30, height: 30)
            .foregroundColor(.white)
            .background(
              RoundedRectangle(
                cornerRadius: 15
              )
            )
        })
        .padding(5)
      }
      .background(
        RoundedRectangle(
          cornerRadius: 20
        )
        .fill(Color.init(.lightGray))
      )
    }
    .padding(.horizontal)
    .frame(height: textViewHeight)
  }
}

struct InputTextView_Previews: PreviewProvider {
  static var previews: some View {
    InputTextView(
      text: .constant(""),
      placeholder: "Type here"
    )
  }
}
