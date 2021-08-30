//
//  DynamicTextView.swift
//  ChatUI
//

import SwiftUI
import UIKit

struct DynamicTextView: UIViewRepresentable {
  let placeholder: String
  let textContainerInset: UIEdgeInsets
  let font: UIFont?
  let textColor: UIColor?
  @Binding var text: String
  @Binding var height: CGFloat

  func makeUIView(context: Context) -> UIView {
    let textView = TextView()
    textView.delegate = context.coordinator
    textView.isEditable = true
    textView.font = font
    textView.textContainerInset = textContainerInset
    textView.isUserInteractionEnabled = true
    textView.isScrollEnabled = true
    textView.alwaysBounceVertical = false
    textView.text = text
    textView.textColor = textColor
    textView.tintColor = textColor
    textView.backgroundColor = .clear
    textView.placeholderLabel?.text = placeholder

    context.coordinator.textView = textView

    return textView
  }

  func updateUIView(_ uiView: UIView, context: Context) {
    if let height = context.coordinator.textView?.contentSize.height {
      DispatchQueue.main.async {
        self.height = height
      }
    }
    context.coordinator.textView?.text = text
  }

  func makeCoordinator() -> Coordinator {
    return Coordinator(dynamicTextField: self)
  }
  
  class Coordinator: NSObject, UITextViewDelegate, NSLayoutManagerDelegate {
    var dynamicTextField: DynamicTextView

    weak var textView: TextView?

    init(dynamicTextField: DynamicTextView) {
      self.dynamicTextField = dynamicTextField
    }

    // MARK: - UITextViewDelegate

    func textViewShouldBeginEditing(_ textView: UITextView) -> Bool {
        textViewDidChangeSelection(textView)
        return true
    }

    func textViewDidChangeSelection(_ textView: UITextView) {
      self.textView?.textViewDidChangeSelection(textView)
      DispatchQueue.main.async { [weak self] in
        self?.dynamicTextField.height = textView.contentSize.height
        self?.dynamicTextField.text = textView.text
      }
    }

  }

}

struct DynamicTextView_Previews: PreviewProvider {
    static var previews: some View {
      DynamicTextView(
        placeholder: "Type here",
        textContainerInset: .init(top: 12, left: 12, bottom: 12, right: 0),
        font: .systemFont(ofSize: 16),
        textColor: .white,
        text: .constant("Hello world"),
        height: .constant(30)
      )
      .previewLayout(.sizeThatFits)
      .frame(width: 300, height: 30)
    }
}
