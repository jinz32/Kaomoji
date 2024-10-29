//
//  ContentView.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/11/24.
//

import SwiftUI
struct EmojiView: View {
    @StateObject private var viewModel = EmojiViewModel()
    @State private var selectedCategory: String = "All"
    @Environment(\.colorScheme) var colorScheme
    var onEmojiSelected: (String) -> Void  // Callback for when a kaomoji is selected

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        VStack {
            // Horizontal scroll for category selection
            ScrollView(.horizontal, showsIndicators: false) {
                LazyHStack {
                    ForEach(viewModel.categories, id: \.self) { category in
                        Button(action: {
                            selectedCategory = category
                        }) {
                            Text(category)
                                .foregroundColor(selectedCategory == category ? .blue : .primary)
                                .padding(5)
                                .background(selectedCategory == category ? Color.blue.opacity(0.2) : Color.clear)
                                .cornerRadius(8)
                        }
                    }
                }
                .padding()
            }
            // Grid of kaomojis for the selected category
            ScrollView {
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.emojisByCategory[selectedCategory] ?? [], id: \.self) { kaomoji in
                        Button(action: {
                            onEmojiSelected(kaomoji.entry)  // Trigger callback
                            viewModel.updateRecentlyUsed(kaomoji)  // Update recents
                        }) {
                            Text(kaomoji.entry)
                                .font(.largeTitle)
                                .minimumScaleFactor(0.1)
                                .foregroundColor(dynamicTextColor(false))
                                .lineLimit(1)
                                .padding(.horizontal, 10)
                        }
                    }
                }
            }
            .frame(height: 250)
        }
        .onAppear {
            viewModel.loadRecentlyUsedEmojis()  // Reload recents on appear
        }
    }
    private func dynamicTextColor(_ isSelected: Bool) -> Color {
        if colorScheme == .dark {
            return isSelected ? .white : .gray
        } else {
            return isSelected ? .black : .primary
        }
    }
}
