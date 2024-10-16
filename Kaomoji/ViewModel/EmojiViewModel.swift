//
//  EmojiViewModel.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/11/24.
//

import Foundation

class EmojiViewModel: ObservableObject {
    @Published var emojisDict: [String: Kaomoji] = [:] // Dictionary to store Kaomoji
    @Published var emojiList: [Kaomoji] = []
    private let service = JsonService()

    func fetchEmojis() {
        Task {
            if let fetchedEmojis = try await service.parseData() {
                DispatchQueue.main.async {
                    self.emojisDict = fetchedEmojis                  // Store the fetched dictionary
                    self.emojiList = Array(fetchedEmojis.values)     // Convert dictionary values to a list
                    print(self.emojiList)
                }
            } else {
                print( "error")
            }
        }

    }
}
