//
//  ContentView.swift
//  Kaomoji
//
//  Created by Jonathan Zheng on 9/23/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            GeometryReader {_ in
                Text("")
            }
            EmojiView()
        }
        .background(Color("Color").edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    ContentView()
}
