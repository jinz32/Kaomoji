//
//  ContentView.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    // State to store the selected emoji
    @State private var selectedEmoji: String = ""

    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader { _ in
                VStack {
                    // Display the selected emoji
                    if !selectedEmoji.isEmpty {
                        Text("Selected Emoji: \(selectedEmoji)")
                            .font(.largeTitle)
                            .padding()
                    } else {
                        Text("Select an emoji or kaomoji!")
                            .font(.headline)
                            .padding()
                    }
                }
            }

            // EmojiView with the onEmojiSelected closure
            EmojiView { emoji in
                // Update the selected emoji when tapped
                selectedEmoji = emoji
                print("Emoji selected: \(emoji)")
            }
            .frame(height: 300) // Adjust the height as needed
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
}
