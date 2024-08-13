//
//  DrawCardView.swift
//  three-dimensional-card
//
//  Created by 전성훈 on 8/8/24.
//

import SwiftUI
import SceneKit

struct ThreeDimensionalBoxView: View {
    var body: some View {
        
        NavigationStack {
            VStack {
                SceneView(
                    scene: {
                        let scene = SCNScene(named: "Art.scnassets/box.scn")!
                        
                        let cameraNode = scene.rootNode
                            .childNode(withName: "camera", recursively: false)
                        cameraNode?.position = SCNVector3(x: 0, y: 0.6, z: 1.2)
                        
                        if let node = scene.rootNode.childNode(withName: "box2", recursively: true) {
                            let moveUp = SCNAction.moveBy(x: 0.0, y: 0.1, z: 0, duration: 1.0)
                            let moveDown = SCNAction.moveBy(x: 0.0, y: -0.1, z: 0, duration: 1.0)
                            let moveSequence = SCNAction.sequence([moveUp, moveDown])
                            let moveRepeat = SCNAction.repeatForever(moveSequence)
                            
                            let rotate = SCNAction.rotateBy(x: 0, y: CGFloat(Double.pi * 2), z: 0, duration: 10)
                            let rotateRepeat = SCNAction.repeatForever(rotate)
                            
                            let group = SCNAction.group([moveRepeat, rotateRepeat])
                            node.runAction(group)
                            
                            let constraint = SCNLookAtConstraint(target: node)
                            constraint.isGimbalLockEnabled = true
                            cameraNode?.constraints = [constraint]
                        }
                        
                        return scene
                    }(),
                    options: [.autoenablesDefaultLighting, .allowsCameraControl]
                )
                .frame(height: 300)
                .padding()
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .navigationTitle("3D Box")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ThreeDimensionalBoxView()
}
