//
//  TextView.swift
//  ChatUI
//

import UIKit

class TextView: UITextView, UITextViewDelegate {
  var placeholderLabel: UILabel?

  override init(frame: CGRect, textContainer: NSTextContainer?) {
    super.init(frame: frame, textContainer: textContainer)

    initView()
  }

  required init?(coder: NSCoder) {
    super.init(coder: coder)

    initView()
  }

  override func layoutSubviews() {
    super.layoutSubviews()

    placeholderLabel?.frame = bounds.inset(by: textContainerInset)
    placeholderLabel?.frame.origin.x += textContainer.lineFragmentPadding
  }

  func initView() {
    let placeholderLabel: UILabel = .init()
    placeholderLabel.textColor = .placeholderText
    self.placeholderLabel = placeholderLabel
    addSubview(placeholderLabel)
  }

  // MARK: - UITextViewDelegate

  func textViewDidChangeSelection(_ textView: UITextView) {
    placeholderLabel?.isHidden = !textView.text.isEmpty
  }
}
