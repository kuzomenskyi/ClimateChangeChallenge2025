//
//  MainVM.swift
//  TreeForYourKid
//
//  Created by vladimir.kuzomenskyi on 22.02.2025.
//

import SwiftUI
import Combine

final class MainVM: ObservableObject {
    enum Route {
        case plantATree
        case none
    }
    
    // MARK: Constant
    static let mock: MainVM = .init()
    
    // MARK: Private Constant
    
    // MARK: Variable
    var cancellables: Set<AnyCancellable> = .init()
    @Published var route: Route = .none
    
    // MARK: Private Variable
    private(set) var onAppearBlock: ((_ viewModel: MainVM) -> Void)?
    
    // MARK: Init
    init() {
        
    }
    
    init(onAppearBlock: ((_ viewModel: MainVM) -> Void)? = nil) {
        self.onAppearBlock = onAppearBlock
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    func configure() {
        onAppearBlock?(self)
        onAppearBlock = nil
    }
    
    // MARK: Private Function
}

