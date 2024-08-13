//
//  ButtonStyle.swift
//  three-dimensional-card
//
//  Created by 전성훈 on 8/8/24.
//

import SwiftUI

struct CustomButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .font(.headline)
            .foregroundStyle(
                configuration.isPressed ? .gray : .white
            )
            .padding(16)
            .frame(
                maxWidth: .infinity,
                minHeight: 30,
                maxHeight: 55
            )
            .background(
                configuration.isPressed ? .gray : .black
            )
            .clipShape(.rect(cornerRadius: 36))
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 16)
    }
}
