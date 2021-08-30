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
  @State private var scrollToBottom: Bool = true

  init() {
    viewModel = .init()
  }

  var body: some View {
    NavigationView {
      VStack {
        ScrollView {
          ScrollViewReader { proxy in
            LazyVStack(alignment: .center, spacing: 4, pinnedViews: [.sectionHeaders]) {
              ForEach(viewModel.dataSource.indices, id: \.self) { outerIndex in
                Section(
                  header: SectionMessageView(
                    section: viewModel.dataSource[outerIndex]
                  )
                ) {
                  ForEach(viewModel.dataSource[outerIndex].messages.indices, id: \.self) { innerIndex in
                    MessageView(
                      message: viewModel.dataSource[outerIndex].messages[innerIndex]
                    )
                    .id(viewModel.dataSource[outerIndex].messages[innerIndex].id)
                  }
                }
              }
            }
            .padding()
          }
        }
        InputTextView(
          text: $viewModel.inputText,
          isEnableSendButton: viewModel.isEnabledSendButton,
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
