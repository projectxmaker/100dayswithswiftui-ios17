//
//  ContentView.swift
//  D20GuessTheFlag
//
//  Created by Pham Anh Tuan on 10/16/23.
//

import SwiftUI

struct ContentView: View {
    @State private var showingScore = false
    @State private var scoreTitle = ""
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var userScore: Int = 0
    @State private var answeredQuestion: Int = 0
    
    @State private var tappedFlagIndex: Int = -1
    
    private let maximumNumberOfQuestions: Int = 8
    
    private var alertConfirmationButtonTitle: String {
        isTimeToRestartGame ? "Restart" : "Continue"
    }
    
    private var isTimeToRestartGame: Bool {
        answeredQuestion >= maximumNumberOfQuestions
    }
    
    var body: some View {
        ZStack {
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3)
            ], center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            
            VStack {
                Spacer()
                
                Text("Guess the Flag")
                    .font(.largeTitle.weight(.bold))
                    .foregroundStyle(.white)
                
                VStack(spacing: 15) {
                    VStack {
                        Text("Tap the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle(.secondary)
                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                    }
                    
                    ForEach(0..<3) { number in
                        Button {
                            flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .clipShape(.capsule)
                                .shadow(radius: 5)
                        }
                        .opacity(tappedFlagIndex == number || tappedFlagIndex == -1 ? 1 : 0.25)
                        .scaleEffect(CGSize(width: tappedFlagIndex == number || tappedFlagIndex == -1 ? 1.0 : 0.0, height: tappedFlagIndex == number || tappedFlagIndex == -1 ? 1.0: 0.0))
                        .rotation3DEffect(
                            .degrees(tappedFlagIndex == number ? 360: 0),
                                                  axis: (x: 0.0, y: 1.0, z: 0.0)
                        )
                        .animation(tappedFlagIndex != -1 ? .default : nil, value: tappedFlagIndex)
                    }
                }
                .padding()
                .alert(scoreTitle, isPresented: $showingScore) {
                    Button(alertConfirmationButtonTitle, action: tapOnAlertConfirmationButton)
                } message: {
                    Text("Your score is \(userScore)")
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Text("Number of Answered Questions: \(answeredQuestion) / \(maximumNumberOfQuestions)")
                    .foregroundStyle(.white)
                
                Spacer()
                Spacer()
                
                Text("Score: \(userScore)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                
                Spacer()
            }
            .padding()
        }
    }
    
    func flagTapped(_ number: Int) {
        tappedFlagIndex = number
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            userScore += 1
        } else {
            scoreTitle = "Wrong! That's the flag of \(countries[number])"
            userScore = userScore > 0 ? userScore - 1 : userScore
        }

        showingScore = true
        
        answeredQuestion += 1
    }
    
    func tapOnAlertConfirmationButton() {
        tappedFlagIndex = -1
        
        if isTimeToRestartGame {
            restartGame()
        } else {
            askQuestion()
        }
    }
    
    func restartGame() {
        answeredQuestion = 0
    }
    
    func askQuestion() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
}

#Preview {
    ContentView()
}
