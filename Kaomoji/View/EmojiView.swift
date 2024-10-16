//
//  ContentView.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/11/24.
//
import SwiftUI

struct EmojiView: View {
    @StateObject private var viewModel = EmojiViewModel()

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.emojiList.isEmpty {
                    ProgressView("Loading emojis...")
                        .onAppear {
                            viewModel.fetchEmojis()
                        }
                } else {
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.emojiList, id: \.self) { emoji in
                                Button(action: {

                                    print("Kaomoji tapped: \(emoji.entry)")
                                }) {
                                    Text(emoji.entry)
                                        .font(.largeTitle)
                                        .minimumScaleFactor(0.5)
                                        .lineLimit(1)
                                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                                        .padding()
                                        .background(Color.gray.opacity(0.2))
                                        .cornerRadius(10)
                                }
                            }
                        }
                        .padding()
                    }
                    .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height / 3)
                }
            }
            .navigationTitle("Kaomoji Emojis")
        }
    }
}
