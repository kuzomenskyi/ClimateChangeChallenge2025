//
//  PickerVM.swift
//  BeMyTree
//
//  Created by vladimir.kuzomenskyi on 22.02.2025.
//

import SwiftUI
import Combine

final class PickerVM: ObservableObject {
    // MARK: Constant
    static let mock: PickerVM = .init()
    
    // MARK: Private Constant
    
    // MARK: Variable
    var cancellables: Set<AnyCancellable> = .init()
    @Published var selectedSliderTitle: String = "All"
    @Published var places: [Place] = [.fireIsland, .marine, .rockefeller]
    @Published var selectedPlace: Place? = nil
    @Published var treeOrder: TreeOrder? = nil
    @Published var selectedDate: Date? = nil
    
    var isLocationSliderActive: Bool {
        return selectedPlace == nil
    }
    
    var isTreeSliderActive: Bool {
        return treeOrder != nil
    }
    
    var isDateSliderActive: Bool {
        return selectedDate != nil
    }
    
    // MARK: Private Variable
    private(set) var onAppearBlock: ((_ viewModel: PickerVM) -> Void)?
    
    // MARK: Init
    init() {
        
    }
    
    init(onAppearBlock: ((_ viewModel: PickerVM) -> Void)? = nil) {
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

