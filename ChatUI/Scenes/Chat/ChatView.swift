//
//  ContentView.swift
//  ChatUI
//

import SwiftUI

struct ChatView: View {
  @EnvironmentObject var dataManager: DataManager
  @ObservedObject var viewModel: ChatViewModel
  @State private var inputText = ""
  @State private var textViewHeight: CGFloat = 0

  init() {
    viewModel = .init()
  }

  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          LazyVStack(spacing: 4) {
            ForEach(viewModel.dataSource.indices, id: \.self) { outerIndex in
              Section(header: SectionMessageView(section: viewModel.dataSource[outerIndex])) {
                ForEach(viewModel.dataSource[outerIndex].messages.indices, id: \.self) { insideIndex in
                  MessageView(message: viewModel.dataSource[outerIndex].messages[insideIndex])
                    .id(UUID())
                }
              }
            }
          }
          .padding()
        }
        InputTextView(
          text: $viewModel.inputText,
          placeholder: "Text Message",
          sendTextAction: viewModel.createNewMessage(inputText:)
        )
          .padding(.bottom, 10)
      }
      .onAppear(perform: {
        viewModel.add(dataManager: dataManager)
      })
      .navigationBarTitleDisplayMode(.inline)
      .navigationTitle("Company name")
    }
  }
}

struct ChatView_Previews: PreviewProvider {
  static var previews: some View {
    ChatView()
      .environmentObject(DataManager())
  }
}
