//
//  Kaomoji.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/11/24.
//
import SwiftData
import Foundation

@Model
struct Kaomoji: Hashable, Codable {
    var name: String
    var entry: String
    var keywords: [String]
    var category: String?
    
    init(name: String, entry: String, keywords: [String], category: String? = nil) {
        self.name = name
        self.entry = entry
        self.keywords = keywords
        self.category = category
    }
    // MARK: - Codable Conformance
     enum CodingKeys: String, CodingKey {
         case name, entry, keywords, category
     }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.name = try container.decode(String.self, forKey: .name)
        self.entry = try container.decode(String.self, forKey: .entry)
        self.keywords = try container.decode([String].self, forKey: .keywords)
        self.category = try container.decodeIfPresent(String.self, forKey: .category)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(entry, forKey: .entry)
        try container.encode(keywords, forKey: .keywords)
        try container.encodeIfPresent(category, forKey: .category)
    }
}

struct EmojiList: Codable {
    var kaomojiList: [String: Kaomoji]
}
