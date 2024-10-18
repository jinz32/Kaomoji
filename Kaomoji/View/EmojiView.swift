//
//  ContentView.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/11/24.
//
import SwiftUI

/**
 
 1. first display all
 2. create way to determine last index seen
 
 */

struct EmojiView: View {
    @StateObject private var viewModel = EmojiViewModel()
    @State private var selectedCategory: String = "All"
    @Environment(\.colorScheme) var colorScheme
    var onEmojiSelected: (String) -> Void

    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible()),
        GridItem(.flexible())
    ]

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                if viewModel.emojiList.isEmpty {
                    ProgressView("Loading emojis...")
                        .onAppear {
                            viewModel.fetchEmojis()
                        }
                } else {
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack(spacing: 20) {
                            ForEach(viewModel.categories, id: \.self) { category in
                                Button(action: {
                                    selectedCategory = category
                                }) {
                                    Text(category)
                                        .font(.subheadline)
                                        .foregroundColor(selectedCategory == category ? .blue : .primary)
                                        .background(selectedCategory == category ? Color.blue.opacity(0.2) : Color.clear)
                                        .cornerRadius(10)

                                }
                            }

                        }
                        .padding(.horizontal) // Horizontal padding for content spacing
                    }
                    .frame(height: 40)
                    // Display the Kaomojis based on the selected category
                    ScrollView(.vertical, showsIndicators: false) {
                        LazyVGrid(columns: columns, spacing: 20) {
                            ForEach(viewModel.emojisByCategory[selectedCategory] ?? [], id: \.self) { emoji in
                                Button(action: {
                                    print("Kaomoji tapped: \(emoji.entry)")
                                    onEmojiSelected(emoji.entry)
                                }) {
                                    Text(emoji.entry)
                                        .font(.largeTitle)
                                        .minimumScaleFactor(0.1)
                                        .lineLimit(1)
                                        .padding(.horizontal, 10)
                                        .foregroundColor(dynamicTextColor(false))
                                }
                            }
                        }
                    }
                    .frame(width: UIScreen.main.bounds.width)
                }
            }
        }

    }

    // Helper function to dynamically set text color (black or white)
    private func dynamicTextColor(_ isSelected: Bool) -> Color {
        if colorScheme == .dark {
            return isSelected ? .white : .gray
        } else {
            return isSelected ? .black : .primary
        }
    }
}
