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

            // Decode the JSON as a dictionary where the keys are String and values are Kaomoji objects
            let emojiList = try decoder.decode([String: Kaomoji].self, from: data)

            print("Decoded data:", emojiList)
            return emojiList
        } catch {
            print("Error reading or decoding data:", error.localizedDescription)
            return nil
        }
    }
}
