//
//  GameView.swift
//  MathTrainer
//
//  Created by Oleg Gavashi on 08.08.2023.
//

import SwiftUI

enum GameStatus {
    case SETTINGS, PLAYING
}

struct Game: View {
    @State private var gameStatus: GameStatus = GameStatus.SETTINGS
    @State private var amountOfQuestions = 5
    @State private var baseNumber = 2
    
    
    var body: some View {
        GameWrapper {
            if gameStatus == GameStatus.PLAYING {
                GameScreen(baseNum: baseNumber, questionsAmount: amountOfQuestions, gameStatus: $gameStatus)
            }
            if gameStatus == GameStatus.SETTINGS {
                SettingsPage(amountOfQuestions: $amountOfQuestions, baseNumber: $baseNumber, gameStatus: $gameStatus)
            }
        }
    }
}
