//
//  JsonService.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/11/24.
//

import Foundation

class JsonService {

    // Function to parse and update JSON data
    func parseData() async -> [String: Kaomoji]? {
        // Read the JSON from the bundle
        guard let url = Bundle.main.url(forResource: "Kaomoji", withExtension: "json") else {
            print("File not found in bundle")
            return nil
        }
        do {
            let data = try Data(contentsOf: url)
            let decoder = JSONDecoder()
            // Decode the JSON as a dictionary where the keys are String and values are Kaomoji
            var emojiList = try decoder.decode([String: Kaomoji].self, from: data)
            print("Original data:", emojiList)
            // Increment and update the ID for each Kaomoji
            var index = 1
            for key in emojiList.keys {
                emojiList[key]?.id = index  // Set the unique identifier
                index += 1
            }
            print("Data with IDs:", emojiList)
            return emojiList
        } catch {
            print("Error reading or decoding data:", error.localizedDescription)
            return nil
        }
    }
}
