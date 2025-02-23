//
//  ListView.swift
//  TreeForYourKid
//
//  Created by vladimir.kuzomenskyi on 21.02.2025.
//

import SwiftUI
import Combine

struct ListView: View {
    // MARK: Constant
    
    // MARK: Private Constant
    
    // MARK: Variable
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            
            ZStack {
                if let selectedPlace = viewModel.placeSelected {
                    Group {
                        Rectangle()
                            .fill(mainColor)
                        
                        VStack {
                            HStack {
                                Button(action: {
                                    viewModel.placeSelected = nil
                                }, label: {
                                    Text("Go back")
                                })
                                Spacer()
                            }
                            Spacer()
                        }
                    }
                } else {
                    VStack {
                        HStack {
                            Spacer()
                                .frame(width: 2)
                            Text("Places nearby")
                                .font(.largeTitle)
                            Spacer()
                        }
                        .padding([.top], 20)
                        
                        ScrollView(.vertical) {
                            LazyVStack(spacing: 15) {
                                    Spacer()
                                        .frame(height: 0)
                                    ForEach(viewModel.places) { place in
                                        getButton(forPlace: place)
                                    }
                                }
                            Spacer()
                                .frame(height: 100)
                            Text("Know more locations ready to support the idea?")
                                .italic()
                                .multilineTextAlignment(.center)
                            
                            Button(action: {}, label: {
                                    ZStack {
                                        Capsule()
                                            .frame(height: 70)
                                            .foregroundColor(Color(hex: "#9bcfa9").opacity(0.35))
                                        Text("Contact us")
                                    }
                            })
                            .frame(height: 70)
                            .clipShape(Rectangle())
                            .buttonStyle(.plain)
                        }
                        .scrollIndicators(.hidden)
                    }
                    .padding([.horizontal], 20)
                }
            }
        }
        .background(mainColor)
        .onAppear {
            viewModel.configure()
        }
    }
    
    // MARK: Private Variable
    @State private var mainColor = Color(hex: "#f2faf4")
    @State private var fillColor: Color = Color.gray.opacity(0.6)
    @StateObject private var viewModel: ListVM
    
    // MARK: Init
    init(viewModel: ListVM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    init(onAppearBlock: ((_ viewModel: ListVM) -> Void)? = nil) {
        let vm: ListVM = .init(onAppearBlock: onAppearBlock)
        self._viewModel = StateObject(wrappedValue: vm)
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
    private func getButton(forPlace place: Place) -> some View {
        Button(action: {
            viewModel.placeSelected = place
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(fillColor)
                place.image
                    .resizable()
                    .frame(height: 220)
                    .overlay {
                        Rectangle()
                            .opacity(0.15)
                            .cornerRadius(20)
                    }
                    .clipShape(
                        RoundedRectangle(cornerRadius: 20)
                    )
                VStack {
                    Spacer()
                    HStack {
                        Spacer()
                            .frame(width: 20)
                        Text(place.title)
                            .font(.system(size: 22, weight: .semibold))
                            .foregroundStyle(Color.white)
                        Spacer()
                    }
                }
                .padding(.bottom, 20)
            }
            .frame(height: 220)
            .cornerRadius(20)
        })
        .buttonStyle(.plain)
    }
}

struct ListView_Previews: PreviewProvider {
    static var previews: some View {
        let view = ListView(viewModel: .mock)
        
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

