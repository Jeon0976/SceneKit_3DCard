//
//  CardListView.swift
//  three-dimensional-card
//
//  Created by 전성훈 on 8/8/24.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()
    
    var body: some View {
        NavigationStack {
            ZStack {
                GeometryReader { geometry in
                    VStack {
                        CardThreeDimensional(
                            scene: $viewModel.scene,
                            options: []
                        )
                        .frame(width: geometry.size.width, height: geometry.size.height)
                        .ignoresSafeArea(.all)
                        
                        Spacer()
                    }
                    .overlay(
                        detailView
                            .frame(width: geometry.size.width, height: geometry.size.height)
                            .position(x: geometry.size.width / 2, y: geometry.size.height * 0.2)
                            .opacity(viewModel.showDetail == .outside ? 1 : 0)
                    )
                }
                
                VStack {
                    Spacer()
                    
                    VStack {
                        attributeSettingTable
                        HStack {
                            detailButtonIn3D
                                .padding(.leading)
                            detailButtonOutside
                                .padding(.trailing)
                        }
                    }
                    .navigationTitle("Profile")
                    .navigationBarTitleDisplayMode(.inline)
                }
            }
            .background(viewModel.selectedColor.opacity(0.1))
        }
    }
    
    private var attributeSettingTable: some View {
        VStack {
            HStack {
                Text("✷ Colors: ")
                Spacer()
                
                SphereView(color: .yellow) { viewModel.changedColor(color: .yellow) }
                Spacer()
                
                SphereView(color: .green) { viewModel.changedColor(color: .green) }
                Spacer()
                
                SphereView(color: .blue) { viewModel.changedColor(color: .blue) }
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 42))
            .padding([.leading, .trailing])
            
            HStack {
                Text("✷ Actions: ")
                Spacer()
                
                Button(action: {
                    viewModel.activeRotationAnimation()
                }, label: {
                    Text("Rotation")
                        .foregroundStyle(.black)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 24))
                })
                Spacer()
                
                Button(action: {
                    viewModel.activeBounceAnimation()
                }, label: {
                    Text("Bounce")
                        .foregroundStyle(.black)
                        .padding(EdgeInsets(top: 4, leading: 8, bottom: 4, trailing: 8))
                        .background(.white)
                        .clipShape(.rect(cornerRadius: 24))
                })
                Spacer()
            }
            .padding()
            .background(Color.gray.opacity(0.4))
            .clipShape(.rect(cornerRadius: 42))
            .padding([.leading, .trailing])
        }
        .padding(.bottom)
    }
    
    private var detailButtonIn3D: some View {
        Button{
            viewModel.showDetail = viewModel.showDetail == .card ? .none : .card
            viewModel.showDetailProfile()
        } label: {
            Text("Detail In 3Dcard")
                .foregroundStyle(viewModel.showDetail == .card ? Color.white : Color.gray)
        }
        .buttonStyle(CustomButtonStyle())
    }
    
    private var detailButtonOutside: some View {
        Button {
            viewModel.showDetail = viewModel.showDetail == .outside ? .none : .outside
            viewModel.showDetailProfile()
        } label: {
            Text("Detail OutSide")
                .foregroundStyle(viewModel.showDetail == .outside ? Color.white : Color.gray)
        }
        .buttonStyle(CustomButtonStyle())
    }
    
    private var detailView: some View {
        let details = [
            "Name: \(viewModel.profile.name)",
            "Position: \(viewModel.profile.position)",
            "Birth: \(viewModel.profile.birth)",
            "Email: \(viewModel.profile.email)",
            "Phone: \(viewModel.profile.phone)"
        ]
        
        return VStack(alignment: .leading) {
            ForEach(details, id: \.self) { detail in
                Text(detail)
                    .padding(.bottom, 8)
                    .foregroundStyle(.black)
            }
        }
        .background(Color.white.opacity(0.7))
    }
}

#Preview {
    ProfileView()
}
