//
//  ViewModel.swift
//  three-dimensional-card
//
//  Created by 전성훈 on 8/8/24.
//

import SwiftUI
import SceneKit

enum Detail {
    case none
    case card
    case outside
}

final class ProfileViewModel: ObservableObject {
    var profile = CharacterCard(
        name: "전성훈",
        birth: "1995-12-29",
        position: "iOS Developer",
        email: "seonghun.jeon@illuminarea.com",
        phone: "010-6601-0976"
    )
    
    @Published var selectedColor: Color = .white
    @Published var showDetail: Detail = .none
    
    @Published var scene: SCNScene = {
        let scene = SCNScene(named: "Art.scnassets/card2.scn")!
        
        let cameraNode = SCNNode()
        cameraNode.camera = SCNCamera()
        cameraNode.position = SCNVector3(x: 0, y: 3.8, z: 20)
        cameraNode.look(at: SCNVector3(x: 0, y: 3.6, z: 0))
        
        let lightNode = SCNNode()
        lightNode.light = SCNLight()
        lightNode.light?.type = .spot
        lightNode.light?.intensity = 1500
        lightNode.position = SCNVector3(x: 3, y: 20, z: 30)
        lightNode.look(at: SCNVector3(x: 0, y: 12, z: 10))
        
        if let cardNode = scene.rootNode.childNode(withName: "card", recursively: false) {
            let material = cardNode.geometry?.firstMaterial
            material?.emission.contents = UIColor.white
            material?.emission.intensity = 0.2
            
            let imageNode = SCNNode(geometry: SCNPlane(width: 1.9, height: 1.9))
            imageNode.position = SCNVector3(0, -0.02, 0.2)
            imageNode.name = "poster"
            
            let image = UIImage(named: "seonghun_t")
            let imageMaterial = SCNMaterial()
            imageMaterial.diffuse.contents = image
            imageMaterial.isDoubleSided = true
            
            imageNode.geometry?.materials = [imageMaterial]
            imageNode.eulerAngles = SCNVector3(x: 0, y: .pi, z: .pi)
                        
            cardNode.addChildNode(imageNode)
        }
        
        scene.rootNode.addChildNode(cameraNode)
        scene.rootNode.addChildNode(lightNode)
        
        return scene
    }()
    
    func changedColor(color: Color) {
        selectedColor = color
        
        updateCardColor(with: UIColor(color))
    }
    
    private func updateCardColor(with color: UIColor) {
        guard let cardNode = scene.rootNode.childNode(withName: "card", recursively: false) else {
            return
        }
        
        let material = cardNode.geometry?.firstMaterial
        material?.diffuse.contents = color
    }
    
    func activeRotationAnimation() {
        guard let cardNode = scene.rootNode.childNode(withName: "card", recursively: false) else {
            return
        }
        
        let slowRotation = SCNAction.rotateBy(x: 0.01, y: .pi, z: 0.01, duration: 0.8)
        let fastRotation = SCNAction.rotateBy(x: -0.01, y: .pi, z: -0.01, duration: 0.6)
        let bounce = SCNAction.rotateBy(x: 0, y: .pi * 0.1, z: 0, duration: 0.15)
        let bounceBack = SCNAction.rotateBy(x: 0, y: .pi * -0.15, z: 0, duration: 0.2)
        let origin = SCNAction.rotateBy(x: 0, y: .pi * 0.05, z: 0, duration: 0.15)
        
        let sequce = SCNAction.sequence([
            slowRotation,
            fastRotation,
            bounce,
            bounceBack,
            origin,
            SCNAction.wait(duration: 1.0)
        ])
        let repeatAction = SCNAction.repeat(sequce, count: 1)
        
        cardNode.runAction(repeatAction)
    }
    
    func activeBounceAnimation() {
        guard let cardNode = scene.rootNode.childNode(withName: "card", recursively: true) else {
            return
        }
        
        let moveUp = SCNAction.moveBy(x: 0, y: 3, z: 0, duration: 0.5)
        let moveDown = SCNAction.moveBy(x: 0, y: -3, z: 0, duration: 0.5)
        
        let sequce = SCNAction.sequence([moveUp, moveDown])
        let repeatAction = SCNAction.repeat(sequce, count: 1)
        
        cardNode.runAction(repeatAction)
    }
    
    func showDetailProfile() {
        switch showDetail {
        case .none:
            showDetailInCard(active: false)
        case .card:
            showDetailInCard(active: true)
        case .outside:
            showDetailInCard(active: false)
        }
    }
    
    private func showDetailInCard(active: Bool) {
        guard let cardNode = scene.rootNode.childNode(withName: "card", recursively: true),
              let posterNode = scene.rootNode.childNode(withName: "poster", recursively: true) else {
            return
        }
        
        posterNode.geometry?.materials.first?.transparency = active ? 0.3 : 1.0
        
        if active {
            let profileDetails = [
                ("\(profile.name)", SCNVector3(x: -0.8, y: -0.6, z: 0.2)),
                ("\(profile.position)", SCNVector3(x: -0.8, y: -0.4, z: 0.2)),
                ("\(profile.birth)", SCNVector3(x: -0.8, y: -0.2, z: 0.2)),
                ("\(profile.email)", SCNVector3(x: -0.8, y: 0.0, z: 0.2)),
                ("\(profile.phone)", SCNVector3(x: -0.8, y: 0.2, z: 0.2))
            ]

            for (text, position) in profileDetails {
                let textGeometry = SCNText(string: text, extrusionDepth: 0.1)
                textGeometry.firstMaterial?.diffuse.contents = UIColor.black
                textGeometry.font = .boldSystemFont(ofSize: 10)
                
                let textNode = SCNNode(geometry: textGeometry)
                textNode.position = position
                textNode.scale = SCNVector3(x: 0.01, y: 0.01, z: 0.01)
                textNode.eulerAngles = SCNVector3(x: 0, y: .pi, z: .pi)
                
                cardNode.addChildNode(textNode)
            }
        } else {
            cardNode.childNodes
                .filter { $0.geometry is SCNText }
                .forEach { $0.removeFromParentNode() }
        }
    }
}
