//
//  Tree.swift
//  BeMyTree
//
//  Created by vladimir.kuzomenskyi on 22.02.2025.
//

import SwiftUI
import Combine

struct TreeOrder: Identifiable {
    let id: String = UUID().uuidString
    let title: String
    let image: Image
    
    var pcs: Int
}
