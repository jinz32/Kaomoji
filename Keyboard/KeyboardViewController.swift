//
//  KeyboardViewController.swift
//  Keyboard
//
//  Created by Jonathan Zheng on 10/14/24.
//

import UIKit
import SwiftUI

class KeyboardViewController: UIInputViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Embed SwiftUI EmojiView into the UIKit KeyboardViewController
        let emojiView = EmojiView { [weak self] selectedEmoji in
            self?.insertEmoji(selectedEmoji)

        }
        let hostingController = UIHostingController(rootView: emojiView)

        // Add the SwiftUI view to the keyboard's view hierarchy
        addChild(hostingController)
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(hostingController.view)
        // Set constraints for the SwiftUI view
        NSLayoutConstraint.activate([
            hostingController.view.topAnchor.constraint(equalTo: view.topAnchor),
            hostingController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        view.backgroundColor = UIColor.blue
        hostingController.didMove(toParent: self)
    }
    
    private func insertEmoji(_ emoji: String) {
           textDocumentProxy.insertText(emoji)
       }

}
