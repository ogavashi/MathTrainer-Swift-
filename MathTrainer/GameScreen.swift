//
//  GameScreen.swift
//  MathTrainer
//
//  Created by Oleg Gavashi on 08.08.2023.
//

import SwiftUI

struct GameScreen: View {
    let baseNum: Int
    let questionsAmount: Int
    
    @State private var questionCount = 0
    @State private var mistakesCount = 0
    @State private var numbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10]
    @State private var options = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    @State private var number = 0
    @State private var answer = 0
    @State private var showMessage = false
    @State private var showFinish = false

    
    @Binding var gameStatus: GameStatus
    
    func restartGame() {
        questionCount = 0
        mistakesCount = 0
        numbers = Array(0...10)
    }
    
    func finishGame() {
        gameStatus = GameStatus.SETTINGS
    }
    
    func checkStats() {
        if questionCount == questionsAmount {
            showMessage = true
        }
    }
    
    func getNumber() -> Int {
        if numbers.isEmpty {
            numbers = Array(1...10)
        }
        
        let number = numbers.randomElement() ?? 0
        
        if let indexOfNumber = numbers.firstIndex(of: number) {
            numbers.remove(at: indexOfNumber)
        }
        
        return number
    }
    
    func geneateOptions(answer: Int) -> [Int] {
        var generatedOptions = [Int]()
        
        var candidate = baseNum
        while generatedOptions.count < 8 {
            if candidate % baseNum == 0 && candidate <= baseNum * 10 && !generatedOptions.contains(candidate) && candidate != answer {
                generatedOptions.append(candidate)
            }
            candidate += 1
        }
        return generatedOptions
    }
    
    func generateTask() {
        let number = getNumber()
        let answer = number * baseNum
        var options  = [answer]
        
        options.append(contentsOf: geneateOptions(answer: answer))
        
        self.options = options.shuffled()
        self.number = number
        self.answer = answer
    }
    
    func getAlertMessage() -> (String, String) {
        if mistakesCount == 0 {
            return ("Well done! 😁", "Nice, you have zero mistakes.")
        }
        
        if mistakesCount < questionsAmount / 2 {
            return ("Good job! 😊", "Nicely done, i bet you can do better.")
        }
        
        if mistakesCount == questionCount {
            return ("Ops, something went wrong", "Don't worry, take your time and try again when ready.")
        }
        
        return ("Not bad,😉", "Please, try again to get better results.")
    }
    
    var body: some View {
        VStack {
            StatusBar(count: questionCount, total: questionsAmount, showFinish: $showFinish)
            Spacer()
            Text("\(number) x \(baseNum) = ")
                .font(.system(size: 80))
                .fontWeight(.heavy)
            ForEach(0..<options.count/3, id: \.self) { rowIndex in
                HStack {
                    ForEach(0..<3) { columnIndex in
                        let index = rowIndex * 3 + columnIndex
                        if index < options.count {
                            ChoiceButton(option: options[index], answer: answer, action: generateTask, questionsCount: $questionCount, mistakesCount: $mistakesCount)
                        } else {
                            Spacer()
                        }
                    }
                }
            }
            Spacer()
                .onAppear(perform: generateTask)
                .onChange(of: questionCount, perform: { _ in
                    checkStats()
                }
                )
                .alert(getAlertMessage().0, isPresented: $showMessage) {
                    Button("Restart", action: restartGame)
                    Button("Finish", action: finishGame)
                } message: {
                    Text(getAlertMessage().1)
                }
                .alert("Are you sure ?", isPresented: $showFinish) {
                    Button("Yes") {
                        gameStatus = GameStatus.SETTINGS
                    }
                    Button("No") {
                        
                    }
                } message: {
                    Text(getAlertMessage().1)
                }
        }
    }
}
