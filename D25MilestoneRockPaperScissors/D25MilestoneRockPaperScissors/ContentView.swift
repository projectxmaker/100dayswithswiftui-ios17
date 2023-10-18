//
//  ContentView.swift
//  D25MilestoneRockPaperScissors
//
//  Created by Pham Anh Tuan on 10/18/23.
//

import SwiftUI

struct ContentView: View {
    @State private var choices = ["fist", "scissor", "paper"].shuffled()
    @State private var results = ["Win", "Lose"].shuffled()
    
    @State private var botChoiceIndex = Int.random(in: 0..<3)
    
    private var botChoiceName: String {
        choices[botChoiceIndex]
    }
    
    private var expectedResult: String {
        results[0]
    }
    
    private let maximumNumberOfRounds: Int = 10
    @State private var answeredRounds: Int = 0
    @State private var score: Int = 0
    @State private var showFinalResultAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(colors: [.blue, .black], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                VStack(spacing: 20) {
                    Image(botChoiceName)
                        .imageScale(.small)
                    
                    Text(expectedResult)
                        .font(.largeTitle.bold())
                        .foregroundStyle(.white)
                        .shadow(color: .white, radius: 1)
                    
                    VStack {
                        ForEach(0..<3) { index in
                            Button {
                                selectAChoice(index)
                            } label: {
                                Image(choices[index])
                                    .imageScale(.medium)
                                    .shadow(color: .white, radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
                            }
                        }
                    }
                }

                Text("Round \(answeredRounds) / \(maximumNumberOfRounds) | Score \(score)")
                    .font(.headline.bold())
                    .foregroundStyle(.white)
                    .shadow(radius: /*@START_MENU_TOKEN@*/10/*@END_MENU_TOKEN@*/)
            }
            .padding()
        }
        .alert("Final Result", isPresented: $showFinalResultAlert) {
            Button("Restart") {
                restartTheGame()
            }
        } message: {
            Text("Score \(score)")
        }

    }
    
    func selectAChoice(_ index: Int) {
        let userChoice = choices[index]
        
        switch botChoiceName {
        case "fist":
            if (expectedResult == "Win" && userChoice == "paper") || (expectedResult == "Lose" && userChoice == "scissor") {
                score += 1
            } else {
                score -= 1
            }
        case "scissor":
            if (expectedResult == "Win" && userChoice == "fist") || (expectedResult == "Lose" && userChoice == "paper") {
                score += 1
            } else {
                score -= 1
            }
        case "paper":
            if (expectedResult == "Win" && userChoice == "scissor") || (expectedResult == "Lose" && userChoice == "fist") {
                score += 1
            } else {
                score -= 1
            }
        default:
            // do nothing
            score = score
        }
        
        answeredRounds += 1
        
        if answeredRounds == maximumNumberOfRounds {
            showFinalResultAlert = true
        } else {
            // randomize data for next round
            choices.shuffle()
            botChoiceIndex = Int.random(in: 0..<3)
            results = ["Win", "Lose"].shuffled()
        }
    }
    
    func restartTheGame() {
        answeredRounds = 0
        score = 0
        
        // randomize data for next round
        choices.shuffle()
        botChoiceIndex = Int.random(in: 0..<3)
        results = ["Win", "Lose"].shuffled()
    }
}

#Preview {
    ContentView()
}
