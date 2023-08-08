//
//  GameWrapper.swift
//  MathTrainer
//
//  Created by Oleg Gavashi on 08.08.2023.
//

import SwiftUI

struct GameWrapper<Content: View>: View {
    
    let content: Content
    
    init(@ViewBuilder content: () -> Content) {
        self.content = content()
    }
    
    
    var body: some View {
        ZStack {
            VStack {
                content
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(LinearGradient(gradient: Gradient(colors: [Color.yellow, Color.mint]), startPoint: .top, endPoint: .bottom))
    }
}

