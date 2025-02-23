//
//  MainView.swift
//  TreeForYourKid
//
//  Created by vladimir.kuzomenskyi on 22.02.2025.
//

import SwiftUI
import Combine

struct MainView: View {
    // MARK: Constant
    
    // MARK: Private Constant
    private let greenColor = Color(hex: "#606E52")
    
    // MARK: Variable
    var body: some View {
        GeometryReader { geometry in
            let size = geometry.size
            Group {
                ZStack {
                    getForestImage(forGeometry: geometry)
                    
                    VStack {
                        HStack {
                            Button(action: {}, label: {
                                Image("burger")
                                    .renderingMode(.template)
                                    .resizable()
                                    .foregroundStyle(Color.white)
                            })
                            .frame(width: 30, height: 27)
                            
                            Text("Be my tree".uppercased())
                                .font(.system(size: 25))
                                .padding(.leading, 10)
                                .foregroundStyle(Color.white)
                            
                            Spacer()
                        }
                        
                        HStack {
                            Spacer()
                                .frame(width: 20)
                            Text("Stop deforestation today")
                                .italic()
                                .foregroundStyle(Color.white)
                                .opacity(0.8)
                            Spacer()
                        }
                        .padding(.top, 5)
                        
                        Spacer()
                            .frame(height: 40)
                        
                        getPlantTreeBtn()
                        
                        VStack {
                            HStack {
                                getMenuBtn(forSize: size, withTitle: "Maps", image: Image("location-pin")) {
                                    print("maps tapped")
                                }
                                getMenuBtn(forSize: size, withTitle: "Calendar", image: Image("calendar")) {
                                    print("calendar tapped")
                                }
                            }
                            HStack {
                                getMenuBtn(forSize: size, withTitle: "About us", image: Image("group")) {
                                    print("about us tapped")
                                }
                                getMenuBtn(forSize: size, withTitle: "Favourites", image: Image("bookmark")) {
                                    print("bookmarks tapped")
                                }
                            }
                        }
                        .padding(.top, 90)
                        
                        Spacer()
                        
                    }
                    .padding([.horizontal, .vertical], 15)
                }
            }
        }
        .onAppear {
            viewModel.configure()
        }
    }
    
    // MARK: Private Variable
    @StateObject private var viewModel: MainVM
    
    // MARK: Init
    init(viewModel: MainVM) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    init(onAppearBlock: ((_ viewModel: MainVM) -> Void)? = nil) {
        let vm: MainVM = .init(onAppearBlock: onAppearBlock)
        self._viewModel = StateObject(wrappedValue: vm)
    }
    
    // MARK: Action
    
    // MARK: Private Action
    
    // MARK: Function
    
    // MARK: Private Function
    private func getMenuBtn(forSize size: CGSize, withTitle title: String, image: Image, action: @escaping () -> Void) -> some View {
        return Button(action: {
            action()
        }, label: {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(Color(hex: "ECF3F4"))
                    .shadow(color: .black.opacity(0.2), radius: 2)
                
                VStack(spacing: 18) {
                    image
                        .resizable()
                        .renderingMode(.template)
                        .foregroundStyle(greenColor)
                        .frame(width: 44, height: 44)
                    
                    Text(title)
                        .foregroundStyle(.black.opacity(0.4))
                }
            }
        })
        .frame(width: size.width * 0.45, height: size.width * 0.45)
    }
    
    private func getForestImage(forGeometry geometry: GeometryProxy) -> some View {
        let size = geometry.size
        return VStack {
            Image("forest")
                .resizable()
                .ignoresSafeArea()
                .frame(height: size.height * 0.4)
                .overlay (
                    LinearGradient(colors: [Color.black.opacity(0.8), Color.black.opacity(0)], startPoint: .bottom, endPoint: .top)
                        .offset(y: -80)
                        .frame(height: size.height * 0.61)
                )
            Spacer()
        }
    }
    
    private func getPlantTreeBtn() -> some View {
        HStack {
            Spacer()
                .frame(width: 20)
            Button(action: {}, label: {
                HStack {
                    Spacer()
                    VStack {
                        Rectangle()
                            .frame(height: 1)
                        
                        Text("Plant a tree".uppercased())
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(Color.white)
                            .tracking(3)
                        
                        Rectangle()
                            .frame(height: 1)
                    }
                    .frame(width: 250)
                    
                    Spacer()
                }
                .offset(y: 20)
            })
            .foregroundStyle(greenColor)
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        let view = MainView(viewModel: .mock)
        
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

