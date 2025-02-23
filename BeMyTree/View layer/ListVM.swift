//
//  ListVM.swift
//  TreeForYourKid
//
//  Created by vladimir.kuzomenskyi on 21.02.2025.
//

import SwiftUI
import Combine

final class ListVM: ObservableObject {
    // MARK: Constant
    static let mock: ListVM = .init()
    
    // MARK: Private Constant
    
    // MARK: Variable
    var cancellables: Set<AnyCancellable> = .init()
    @Published var places: [Place] = [.fireIsland, .rockefeller, .marine]
    @Published var placeSelected: Place? = nil
    
    // MARK: Private Variable
    private(set) var onAppearBlock: ((_ viewModel: ListVM) -> Void)?
    
    // MARK: Init
    init() {
        
    }
    
    init(onAppearBlock: ((_ viewModel: ListVM) -> Void)? = nil) {
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

