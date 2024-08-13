//
//  SphareView.swift
//  three-dimensional-card
//
//  Created by 전성훈 on 8/9/24.
//

import SwiftUI
import SceneKit

struct SphereView: View {
    var color: Color
    var action: () -> Void
    
    var body: some View {
        SphareThreeDimensional(
            scene: {
                let scene = SCNScene()
                let shareColor = UIColor(color)
                                
                let sphereNode = SCNNode(geometry: SCNSphere(radius: 0.2))
                sphereNode.geometry?.firstMaterial?.diffuse.contents = shareColor
                sphereNode.position = SCNVector3(0, 0, 0)
                
                // 빛 노드 추가
                let lightNode = SCNNode()
                lightNode.light = SCNLight()
                lightNode.light?.type = .omni
                lightNode.position = SCNVector3(2, 2, 5)
                
                scene.rootNode.addChildNode(sphereNode)
                scene.rootNode.addChildNode(lightNode)
                
                return scene
            }(),
            options: [.autoenablesDefaultLighting]
        )
        .frame(width: 35, height: 35)
        .background(Color.clear)
        .onTapGesture {
            action()
        }
    }
}
struct SphareThreeDimensional: UIViewRepresentable {
    var scene: SCNScene
    var options: SceneView.Options

    func makeUIView(
        context: Context
    ) -> some UIView {
        let view = SCNView()
        
        view.backgroundColor = .clear
        view.autoenablesDefaultLighting = options.contains(.autoenablesDefaultLighting)

        view.scene = scene

        return view
    }
    
    func updateUIView(
        _ uiView: UIViewType,
        context: Context
    ) {
        
    }
}

#Preview {
    SphereView(color: .blue) {
        print("Action!")
    }
}
