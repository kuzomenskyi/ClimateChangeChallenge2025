//
//  Tree.swift
//  BeMyTree
//
//  Created by vladimir.kuzomenskyi on 22.02.2025.
//

import SwiftUI
import Combine

struct Tree: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let image: Image
    
    init(title: String, image: Image) {
        self.title = title
        self.image = image
    }
    
    init(title: String, image: String) {
        self.title = title
        self.image = Image(image)
    }
}
