//
//  ChoiceButtonView.swift
//  MathTrainer
//
//  Created by Oleg Gavashi on 08.08.2023.
//

import SwiftUI

struct ChoiceButton: View {
    let option: Int
    let answer: Int
    let animationAmont = 1.0
    let action: () -> Void
    
    @State private var isWrong = false
    
    @Binding var questionsCount: Int
    @Binding var mistakesCount: Int
    
    
    func checkAnswer() {
        if option != answer {
            isWrong = true
            mistakesCount += 1
            
            return
        }
        isWrong = false
        questionsCount += 1
        action()
    }
    
    var body: some View {
        VStack {
            Text("\(option)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.primary)
                .frame(width: 80, height: 80)
                .background(isWrong ? Color.red : nil)
                .background(.ultraThinMaterial)
                .cornerRadius(10)
                .padding(10)
        }
        .onTapGesture {
            withAnimation {
                checkAnswer()
            }
        }
        .onChange(of: answer) { _ in
            isWrong = false
        }
    }
}
