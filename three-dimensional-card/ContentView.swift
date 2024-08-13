//
//  ContentView.swift
//  three-dimensional-card
//
//  Created by 전성훈 on 8/8/24.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                NavigationLink(destination: ThreeDimensionalBoxView()) {
                    Text("3D Box")
                }
                .buttonStyle(CustomButtonStyle())
                .padding()
                
                Spacer()
                    .frame(height: 16)
                
                NavigationLink(destination: ProfileView()) {
                    Text("SeongHun Jeon Profile")
                }
                .buttonStyle(CustomButtonStyle())
                .padding()
                
                Spacer()
            }
            .frame(maxWidth: .infinity)
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            .background(.white)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
