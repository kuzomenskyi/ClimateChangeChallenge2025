//
//  PickerView.swift
//  BeMyTree
//
//  Created by vladimir.kuzomenskyi on 22.02.2025.
//

import SwiftUI
import Combine

struct PickerView: View {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            ZStack {
                VStack {
                    ZStack {
                        Image("koala")
                            .resizable()
                            .frame(height: size.height * 0.5)
                            .ignoresSafeArea()
                        
                        HStack {
                            Text("Pick\nlocation")
                                .font(.system(size: 50, weight: .bold))
                                .shadow(radius: 1)
                                .foregroundStyle(Color(hex: "C0CCA4"))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 40)
                        
                    }
                    
                    getLocationView()
                }
                
                VStack {
                    Spacer()
                        .frame(height: size.height * 0.4)
                    HStack {
                        Spacer()
                        getSliderButton(withTitle: "Location", imageTitle: "place_location", isSelected: $viewModel.isLocationSliderActive)
                        getSliderButton(withTitle: "Tree", imageTitle: "tree", isSelected: $viewModel.isTreeSliderActive)
                        getSliderButton(withTitle: "Date", imageTitle: "calendar", isSelected: $viewModel.isDateSliderActive)
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
        }
        .onAppear {
            viewModel.configure()
        }
    }
    
    // MARK: Private Variable
    @StateObject private var viewModel: PickerVM
    
    // MARK: Init
    init(viewModel: PickerVM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    init(onAppearBlock: ((_ viewModel: PickerVM) -> Void)? = nil) {
        let vm: PickerVM = .init(onAppearBlock: onAppearBlock)
        self._viewModel = StateObject(wrappedValue: vm)
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
    private func getLocationView() -> some View {
        ScrollView {
            VStack(spacing: 17) {
                ForEach(viewModel.places) { place in
                    ZStack {
                        place.image
                            .resizable()
                            .frame(height: 200)
                            .overlay {
                                VStack {
                                    Spacer()
                                    LinearGradient(colors: [Color.black.opacity(0.8), Color.clear], startPoint: .bottom, endPoint: .top)
                                        .frame(height: 110)
                                }
                            }
                            .clipShape(
                                .rect(cornerRadius: 22)
                            )
                            .frame(height: 200)
                            .padding(.horizontal, 15)
                        
                        HStack {
                            VStack {
                                Spacer()
                                Text(place.title)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(Color.white)
                                    .shadow(radius: 2)
                                .padding(.bottom, 20)
                            }
                            Spacer()
                        }
                        .padding(.horizontal, 32)
                        
                        VStack {
                            Spacer()
                                .frame(height: 12)
                            HStack {
                                HStack {
                                    Image("location-pin")
                                        .resizable()
                                        .renderingMode(.template)
                                        .frame(width: 20, height: 20)
                                    Text(place.distanceString)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(Color.white)
                                        .shadow(radius: 5)
                                }
                                .foregroundStyle(Color.white.opacity(0.9))
                                
                                Spacer()
                                ZStack {
                                    Circle()
                                        .fill(Color(hex: "908B85").opacity(0.7))
                                    Image("bookmark_empty")
                                        .resizable()
                                        .renderingMode(.template)
                                        .foregroundStyle(Color.white.opacity(0.9))
                                        .frame(width: 20, height: 20)
                                        .offset(y: 2)
                                }
                                .frame(width: 40, height: 40)
                                
                            }
                            .padding(.horizontal, 30)
                            
                            Spacer()
                        }
                    }
                }
            }
        }
    }
    
    private func getSliderButton(withTitle title: String, imageTitle: String, isSelected: Binding<Bool>) -> some View {
        let selectedColor = Color.black
        let deselectedColor = Color(hex: "908B85")
        return HStack {
            Spacer()
            VStack {
                Circle()
                    .frame(width: 38)
                    .overlay {
                        Image(imageTitle)
                            .resizable()
                            .renderingMode(.template)
                            .foregroundStyle(Color.white)
                            .frame(width: 19, height: 19)
                    }
                Text(title)
                    .font(.system(size: 23))
            }
            .foregroundStyle(Color(isSelected.wrappedValue ? selectedColor : deselectedColor))
            Spacer()
        }
    }
}

struct PickerView_Previews: PreviewProvider {
    static var previews: some View {
        let view = PickerView(viewModel: .mock)
        
        return Group {
            view
                .previewDevice(PreviewDevice(rawValue: "iPhone 13"))
                .previewDisplayName("iPhone 13")
            view
                .previewDevice(PreviewDevice(rawValue: "iPhone 14 Pro Max"))
                .previewDisplayName("iPhone 14 Pro Max")
        }
    }
}

