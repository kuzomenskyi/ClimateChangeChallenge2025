//
//  BeMyTreeApp.swift
//  BeMyTree
//
//  Created by vladimir.kuzomenskyi on 22.02.2025.
//

import SwiftUI

@main
struct BeMyTreeApp: App {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: mainVM)
        }
    }
    
    // MARK: Private Variable
    @StateObject private var mainVM: MainVM = .init()
    
    // MARK: Init
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
}
