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
    @Published var recentlyUsed: [Kaomoji] = []
    private let service = JsonService()
    private let recentKey = "recentlyUsedKaomojis"  // UserDefaults key
    private let maxRecents = 10

    init() {
        loadRecentlyUsedEmojis()
        fetchEmojis()
    }

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

    func loadRecentlyUsedEmojis() {
        let recentEntries = UserDefaults.standard.array(forKey: recentKey) as? [String] ?? []
        recentlyUsed = recentEntries.compactMap { emojisDict[$0] }  // Map to existing kaomojis
    }
    // Updates the "Recently Used" list when a new kaomoji is tapped
    func updateRecentlyUsed(_ kaomoji: Kaomoji) {
        // Remove the kaomoji if it already exists to avoid duplicates
        recentlyUsed.removeAll(where: { $0.entry == kaomoji.entry })
        // Add the new kaomoji to the top
        recentlyUsed.insert(kaomoji, at: 0)

        // Limit the list to the maximum allowed size
        if recentlyUsed.count > maxRecents {
            recentlyUsed = Array(recentlyUsed.prefix(maxRecents))
        }

        // Save the updated list to UserDefaults
        let recentEntries = recentlyUsed.map { $0.entry }
        UserDefaults.standard.set(recentEntries, forKey: recentKey)
    }

    var emojisByCategory: [String: [Kaomoji]] {
        var groupedEmojis = Dictionary(grouping: emojiList, by: { $0.category ?? "Misc" })
        if !recentlyUsed.isEmpty {
            groupedEmojis["Recently Used"] = recentlyUsed
        }
        return groupedEmojis
    }

    var categories: [String] {
        var allCategories = Array(emojisByCategory.keys).filter { $0 != "Recently Used" }  // Exclude "Recently Used"
        allCategories.sort()  // Sort remaining categories alphabetically

        if !recentlyUsed.isEmpty {
            allCategories.insert("Recently Used", at: 0)  // Add "Recently Used" at the top
        }

        return allCategories
    }
}
