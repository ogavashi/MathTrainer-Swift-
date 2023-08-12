//
//  SettingsView.swift
//  MathTrainer
//
//  Created by Oleg Gavashi on 08.08.2023.
//

import SwiftUI

struct SettingsPage: View {
    @Binding var amountOfQuestions: Int
    @Binding var baseNumber: Int
    @Binding var gameStatus: GameStatus
    
    func startGame() {
        withAnimation {
            gameStatus = GameStatus.PLAYING
        }
    }
    
    var body: some View {
        VStack(spacing: 30) {
            Section(header: Text("Settings")) {
                Stepper("Amount of questions: \(amountOfQuestions)", value: $amountOfQuestions, in: 5...25)
                VStack(alignment: .leading) {
                    Text("Selected level: \(baseNumber)")
                    Picker("Select number", selection: $baseNumber) {
                        ForEach(1...10, id: \.self) { num in
                            Text("\(num)")
                        }
                    }.pickerStyle(.segmented)
                }
                Button("Start", action: startGame)
            }
            Spacer()
        }
        .padding()
    }
}
