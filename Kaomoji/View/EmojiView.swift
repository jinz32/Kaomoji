//
//  ContentView.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/11/24.
//
import SwiftUI

struct EmojiView: View {
    @StateObject private var viewModel = EmojiViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.emojiList.isEmpty {
                    ProgressView("Loading emojis...")
                        .onAppear {
                            viewModel.fetchEmojis()   // Fetch emojis when the view appears
                        }
                } else {
                    Text("Total Emoji: \(viewModel.emojiList.count)")
                    List(viewModel.emojiList, id: \.self) { emoji in
                        VStack(alignment: .leading) {
                            Text(emoji.name)
                                .font(.headline)
                            Text(emoji.entry)
                                .font(.largeTitle)

                        }
                    }
                }
            }
            .navigationTitle("Kaomoji Emojis")
        }
    }
}
//
// #Preview {
//    EmojiKeyboardView()
// }
