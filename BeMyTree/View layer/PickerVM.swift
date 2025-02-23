//
//  PickerVM.swift
//  BeMyTree
//
//  Created by vladimir.kuzomenskyi on 22.02.2025.
//

import SwiftUI
import Combine

final class PickerVM: ObservableObject {
    struct Page: Identifiable, Equatable {
        let id: UUID = .init()
        let title: String
        let image: Image
        
        static let pickLocation: Page = .init("Pick\nlocation", image: Image("IMG_3256"))
        static let pickTree: Page = .init("Pick\ntree", image: Image("IMG_3255"))
        static let pickDate: Page = .init("Pick\ndate", image: Image("IMG_3254"))
        
        init(_ title: String, image: Image) {
            self.title = title
            self.image = image
        }
    }
    
    // MARK: Constant
    static let mock: PickerVM = .init()
    
    // MARK: Private Constant
    
    // MARK: Variable
    var cancellables: Set<AnyCancellable> = .init()
    @Published var selectedSliderTitle: String = "All"
    @Published var places: [Place] = [.rockefeller, .marine, .fireIsland]
    @Published var preselectedOrder: TreeOrder? = nil
    @Published var selectedPlace: Place? = nil
    @Published var preselectedPlace: Place? = nil
    @Published var treeOrder: TreeOrder? = nil    
    @Published var selectedDate: Date = .now
    @Published var isSelectedPlaceAlertShown = false
    @Published var page: Page = .pickLocation
    @Published var isSelectedOrderAlertShown = false
    @Published var isConfirmButtonEnabled = false
    
    @Published var trees: [Tree] = [
        .init(title: "Basswood", image: Image("Subject 2")),
        .init(title: "American Holly", image: Image("american_holly")),
        .init(title: "Arizona Cypress", image: Image("Arizona Cypress sm")),
        .init(title: "Little Gem Magnolia", image: Image("Little Gem Magnolia")),
        .init(title: "Florida Mapple", image: "Florida Mapple sm"),
        .init(title: "Gray Oak", image: Image("Gray Oak")),
        .init(title: "Crabapple", image: Image("Crabapple")),
        .init(title: "Western Redbud", image: "Western Redbud sm"),
        .init(title: "Mountain Alder", image: "Mountain Alder sm")
    ]
    
    var treeAlertTitle: String {
        return "Confirm adding \(preselectedOrder?.pcs ?? 0) \"\(preselectedOrder?.tree.title ?? "")\"?"
    }
    
    var title: String {
        page.title
    }
    
    var alertTitle: String {
        let placeTitle = preselectedPlace?.title ?? ""
        return "Select \"\(placeTitle)\"?"
    }
    
    var isLocationSliderActive: Bool {
        return page == .pickLocation
    }
    
    var isTreeSliderActive: Bool {
        return page == .pickTree
    }
    
    var isDateSliderActive: Bool {
        return page == .pickDate
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

