//
//  CardThreeDimensional.swift
//  three-dimensional-card
//
//  Created by 전성훈 on 8/13/24.
//

import SwiftUI
import SceneKit

struct CardThreeDimensional: UIViewRepresentable {
    @Binding var scene: SCNScene
    var options: SceneView.Options
    
    func makeUIView(context: Context) -> SCNView {
        let view = SCNView()
        
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = options.contains(.autoenablesDefaultLighting)
        view.scene = scene
        
        return view
    }
    
    func updateUIView(_ uiView: SCNView, context: Context) {
        uiView.scene = scene
    }
}
