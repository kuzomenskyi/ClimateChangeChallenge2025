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
                        viewModel.page.image
                            .resizable()
                            .frame(height: size.height * 0.5)
                            .ignoresSafeArea()
                            .overlay {
                                LinearGradient(colors: [.black, .clear], startPoint: .bottom, endPoint: .top)
                            }
                        
                        HStack {
                            Text(viewModel.title)
                                .font(.system(size: 50, weight: .bold))
                                .shadow(radius: 1)
                                .foregroundStyle(Color(hex: "C0CCA4"))
                            Spacer()
                        }
                        .padding(.horizontal, 20)
                        .padding(.top, 180)
                        
                    }
                    
                    if viewModel.isLocationSliderActive {
                        getLocationView()
                    } else if viewModel.isDateSliderActive {
                        getDateView(forSize: size)
                    } else {
                        getTreeView(forSize: size)
                    }
                }
                
                VStack {
                    Spacer()
                        .frame(height: size.height * 0.475)
                    HStack {
                        Spacer()
                        getSliderButton(withTitle: "Location", imageTitle: "place_location", isSelected: viewModel.isLocationSliderActive)
                        getSliderButton(withTitle: "Tree", imageTitle: "tree", isSelected: viewModel.isTreeSliderActive)
                        getSliderButton(withTitle: "Date", imageTitle: "calendar", isSelected: viewModel.isDateSliderActive)
                        Spacer()
                    }
                    
                    Spacer()
                }
            }
            .ignoresSafeArea()
        }
        .onAppear {
            viewModel.configure()
        }
        .alert(viewModel.alertTitle, isPresented: $viewModel.isSelectedPlaceAlertShown) {
            Button(action: {
                viewModel.isSelectedPlaceAlertShown = false
            }, label: {
                Text("Cancel")
            })
            Button(action: {
                viewModel.isSelectedPlaceAlertShown = false
                withAnimation {
                    viewModel.selectedPlace = viewModel.preselectedPlace
                    viewModel.page = .pickTree
                }
            }, label: {
                Text("Confirm")
            })
        }
        .alert(viewModel.treeAlertTitle, isPresented: $viewModel.isSelectedOrderAlertShown) {
            Button(action: {
                viewModel.preselectedOrder = nil
            }, label: {
                Text("Cancel")
            })
            Button(action: {
                viewModel.treeOrder = viewModel.preselectedOrder
                viewModel.page = .pickDate
            }, label: {
                Text("Confirm")
            })
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
    private func getDateView(forSize size: CGSize) -> some View {
        VStack {
            Spacer()
                .frame(height: size.height * 0.1)
            Text("Schedule your appointment")
            
            Spacer()
                .frame(height: 30)
            DatePicker(selection: $viewModel.selectedDate, in: Date.now..., displayedComponents: .date) {
                Text("Select a date")
            }
            .onChange(of: viewModel.selectedDate) { oldValue, newValue in
                withAnimation {
                    viewModel.isConfirmButtonEnabled = true
                }
            }
            
            Spacer()
            Button(action: {}, label: {
                ZStack {
                    Capsule()
                    Text("Confirm")
                        .foregroundStyle(Color.white)
                }
            })
            .buttonStyle(.plain)
            .disabled(!viewModel.isConfirmButtonEnabled)
            .frame(height: 70)
            
            Spacer()
                .frame(height: 50)
        }
        .padding(.horizontal, 20)
    }
    
    private func getTreeView(forSize size: CGSize) -> some View {
        VStack {
            Spacer()
                .frame(height: 40)
            ScrollView {
                VStack {
                    ForEach(viewModel.trees) { tree in
                        Button(action: {
                            viewModel.preselectedOrder = .init(tree: tree, pcs: 1)
                            viewModel.isSelectedOrderAlertShown = true
                        }, label: {
                            ZStack {
                                RoundedRectangle(cornerRadius: 20)
                                    .foregroundStyle(Color(hex: "#C0CCA4"))
                                    .offset(x: size.width * 0.15)
                                HStack {
                                    tree.image
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 90, height: 90)
                                        .shadow(color: .black.opacity(0.35), radius: 40)
                                    Spacer()
                                }
                                .padding(.horizontal, 20)
                                
                                VStack(alignment: .leading) {
                                    Text(tree.title)
                                        .foregroundStyle(Color(hex: "39452C"))
                                        .font(.system(size: 20, weight: .regular))
                                }
                                .padding(.leading, size.width * 0.3)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .padding(.leading, 5)
                                
                                HStack {
                                    Spacer()
                                    ZStack {
                                        Circle()
                                            .frame(width: 55)
                                            .foregroundStyle(Color(hex: "#606E52").opacity(0.8))
                                        Image("plus")
                                            .resizable()
                                            .renderingMode(.template)
                                            .foregroundStyle(Color.white.opacity(0.8))
                                            .frame(width: 30, height: 30)
                                    }
                                }
                            }
                            .frame(height: 120)
                            .padding(.horizontal, 15)
                        })
                    }
                    Spacer()
                        .frame(height: 100)
                }
            }
            .offset(y: 25)
            Spacer()
        }
        
    }
    
    private func getLocationView() -> some View {
        VStack {
            Spacer()
                .frame(height: 70)
            ScrollView {
                VStack(spacing: 17) {
                    ForEach(viewModel.places) { place in
                        Button(action: {
                            print("selected place: \(place.title)")
                            withAnimation {
                                viewModel.preselectedPlace = place
                            }
                            viewModel.isSelectedPlaceAlertShown = true
                        }, label: {
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
                        })
                    }
                    Spacer()
                        .frame(height: 100)
                }
            }
        }
    }
    
    private func getSliderButton(withTitle title: String, imageTitle: String, isSelected: Bool, completion: (() -> Void)? = nil) -> some View {
        let selectedColor = Color.black
        let deselectedColor = Color(hex: "908B85")
        return Button(action: {
            completion?()
        }, label: {
            HStack {
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
                .foregroundStyle(Color(isSelected ? selectedColor : deselectedColor))
                Spacer()
            }
        })
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

