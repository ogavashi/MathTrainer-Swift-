//
//  StatusBarView.swift
//  MathTrainer
//
//  Created by Oleg Gavashi on 08.08.2023.
//

import SwiftUI

struct StatusBar: View {
    let count: Int
    let total: Int
    
    @State private var showModal = false
    
    @Binding var showFinish: Bool
    
    var body: some View {
        HStack {
            Button("Finish game"){
               showFinish = true
            }
            Spacer()
            Text("\(count)/\(total) questions")
        }
        .padding()
    }
}
