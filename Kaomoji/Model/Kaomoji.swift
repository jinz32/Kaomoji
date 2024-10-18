//
//  Kaomoji.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/11/24.
//

import Foundation

struct Kaomoji: Hashable, Codable {
    var name: String
    var entry: String
    var keywords: [String]
    var category: String?
}

struct EmojiList: Codable {
    var kaomojiList: [String: Kaomoji]
}
