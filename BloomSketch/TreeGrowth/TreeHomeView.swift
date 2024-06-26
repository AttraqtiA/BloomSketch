//
//  TreeHomeView.swift
//  BloomSketch
//
//  Created by MacBook Pro on 17/05/24.
//

import SwiftUI
import SwiftData
import PencilKit
import UIKit

struct TreeHomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query var trees: [Tree]
    @Environment(\.calendar) var calendar
    
    @State private var navigateToDrawingView = false
    @State private var navigateToSettingView = false
    @State private var action: Int? = 0
    
    @State var canvas = PKCanvasView()
    @State var isDraw = true
    @State var color: Color = .black
    @State var type: PKInkingTool.InkType = .pencil
    @State var colorPicker = false
    
    // Responsive
    private let screenWidth = UIScreen.main.bounds.width
    private let screenHeight = UIScreen.main.bounds.height
    
    var body: some View {
        GeometryReader { geometry in
            
            if let tree = trees.first {
                
                NavigationStack {
                    ZStack {
                        LinearGradient(gradient: Gradient(colors: [Color(hex: 0x63B256), Color(.white)]), startPoint: .topLeading, endPoint: .bottomTrailing)
                            .ignoresSafeArea(.all)
                        
                        if UIDevice.current.userInterfaceIdiom == .phone {
                            VStack {
                                // Settings Button
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        navigateToSettingView = true
                                    }) {
                                        Image(systemName: "gearshape.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: screenWidth * 0.05, height: screenWidth * 0.05)
                                            .foregroundColor(Color(hex: 0x1B3F2E))
                                    }
                                    .padding(.top, screenHeight * 0.02)
                                }
                                
                                Text("\(tree.name)'s Den")
                                    .font(.system(size: screenWidth * 0.07, weight: .bold))
                                    .foregroundColor(Color(hex: 0x1B3F2E))
                                
                                ZStack {
                                    if tree.dailyDone {
                                        Image("LeafON")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: screenWidth * 0.35, height: screenWidth * 0.35)
                                            .foregroundColor(.red)
                                    } else {
                                        Image("LeafOff")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: screenWidth * 0.35, height: screenWidth * 0.35)
                                            .foregroundColor(.red)
                                    }
                                    
                                    Text("\(tree.streak)")
                                        .font(.system(size: screenWidth * 0.12, weight: .bold))
                                        .foregroundColor(Color(hex: 0x1B3F2E))
                                }
                                .padding(.vertical, screenHeight * 0.0)
                                
                                Spacer()
                                
                                ZStack {
                                    // Chatbox
                                    
                                    Image(tree.treePhase)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 350 * screenWidth * 0.0025, height: 350 * screenWidth * 0.0025)
                                }
                                
                                VStack {
                                    if tree.dailyDone {
                                        VStack {
                                            Button(action: {
                                                navigateToDrawingView = true
                                            }) {
                                                HStack {
                                                    Text("Draw Again")
                                                        .font(.headline)
                                                        .foregroundColor(Color(hex: 0x1B3F2E))
                                                    
                                                    Image(systemName: "checkmark.circle")
                                                        .foregroundColor(Color(hex: 0x1B3F2E))
                                                }
                                                .padding(.vertical, screenHeight * 0.015)
                                                .padding(.horizontal, screenWidth * 0.15)
                                                .background(Color.white)
                                                .cornerRadius(16)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(hex: 0x1B3F2E), lineWidth: 1)
                                                )
                                            }
                                            .padding(.top, 24)
                                        }
                                        
                                    } else {
                                        Button(action: {
                                            navigateToDrawingView = true
                                            
                                        }) {
                                            Text("Start Drawing Today")
                                                .foregroundColor(.white)
                                                .padding(.vertical, screenHeight * 0.015)
                                                .padding(.horizontal, screenWidth * 0.15)
                                                .background(Color(hex: 0x1B3F2E))
                                                .cornerRadius(16)
                                        }
                                        .padding(.top, 24)
                                    }
                                    
                                    NavigationLink(destination: DrawNavigationLink(), isActive: $navigateToDrawingView) {
                                        EmptyView()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, screenHeight * 0.05)
                            }
                            .padding(.horizontal, screenWidth * 0.07)
                            
                        } else if UIDevice.current.userInterfaceIdiom == .pad {
                            VStack {
                                // Settings Button
                                HStack {
                                    Spacer()
                                    
                                    Button(action: {
                                        navigateToSettingView = true
                                    }) {
                                        Image(systemName: "gearshape.fill")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: screenWidth * 0.05, height: screenWidth * 0.05)
                                            .foregroundColor(Color(hex: 0x1B3F2E))
                                    }
                                    .padding(.top, screenHeight * 0.02)
                                }
                                
                                Text("\(tree.name)'s Den")
                                    .font(.system(size: screenWidth * 0.058, weight: .bold))
                                    .foregroundColor(Color(hex: 0x1B3F2E))
                                    .padding(.top, screenHeight * 0.05)
                                
                                ZStack {
                                    if tree.dailyDone {
                                        Image("LeafON")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: screenWidth * 0.28, height: screenWidth * 0.28)
                                            .foregroundColor(.red)
                                    } else {
                                        Image("LeafOff")
                                            .resizable()
                                            .aspectRatio(contentMode: .fit)
                                            .frame(width: screenWidth * 0.28, height: screenWidth * 0.28)
                                            .foregroundColor(.red)
                                    }
                                    
                                    Text("\(tree.streak)")
                                        .font(.system(size: screenWidth * 0.11, weight: .bold))
                                        .foregroundColor(Color(hex: 0x1B3F2E))
                                }
                                .padding(.vertical, screenHeight * 0.0)
                                
                                Spacer()
                                
                                ZStack {
                                    // Chatbox
                                    
                                    Image(tree.treePhase)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                        .frame(width: 350 * screenWidth * 0.002, height: 350 * screenWidth * 0.0017)
                                }
                                
                                VStack {
                                    if tree.dailyDone {
                                        VStack {
                                            Button(action: {
                                                navigateToDrawingView = true
                                            }) {
                                                HStack {
                                                    Text("Draw Again")
                                                        .font(.headline)
                                                        .foregroundColor(Color(hex: 0x1B3F2E))
                                                    
                                                    Image(systemName: "checkmark.circle")
                                                        .foregroundColor(Color(hex: 0x1B3F2E))
                                                }
                                                .padding(.vertical, screenHeight * 0.015)
                                                .padding(.horizontal, screenWidth * 0.15)
                                                .background(Color.white)
                                                .cornerRadius(16)
                                                .overlay(
                                                    RoundedRectangle(cornerRadius: 16)
                                                        .stroke(Color(hex: 0x1B3F2E), lineWidth: 1)
                                                )
                                            }
                                            .padding(.top, 24)
                                        }
                                        
                                    } else {
                                        Button(action: {
                                            navigateToDrawingView = true
                                        }) {
                                            Text("Start Drawing Today")
                                                .foregroundColor(.white)
                                                .padding(.vertical, screenHeight * 0.015)
                                                .padding(.horizontal, screenWidth * 0.15)
                                                .background(Color(hex: 0x1B3F2E))
                                                .cornerRadius(16)
                                        }
                                        .padding(.top, 24)
                                    }
                                    
                                    NavigationLink(destination: DrawNavigationLink(), isActive: $navigateToDrawingView) {
                                        EmptyView()
                                    }
                                }
                                .frame(maxWidth: .infinity)
                                .padding(.bottom, screenHeight * 0.1)
                            }
                            .padding(.horizontal, screenWidth * 0.07)
                        }
                        NavigationLink(destination: SettingView()
                            .modelContainer(SwiftDataContainer.container), isActive:
                                        $navigateToSettingView) {
                            EmptyView()
                        }
                    }
                }
                .navigationBarBackButtonHidden(true) // Hide back button
                .onAppear {
                    if calendar.component(.hour, from: Date()) >= 19 && tree.dailyDone {
                        tree.dailyDone = false
                    }
                }
            }
        }
    }
}


#Preview {
    TreeHomeView()
        .modelContainer(SwiftDataContainer.container)
}
