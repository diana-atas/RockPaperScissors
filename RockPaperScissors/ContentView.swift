//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Diana Atas on 10/06/23.
//

import SwiftUI

struct ContentView: View {
    @State private var currentMove = Int.random(in: 0...2)
    @State private var shouldWin = Bool.random()
    @State private var scoreTitle = ""
    @State private var showingScore = false
    @State private var score = 0
    @State private var questionNumber = 1
    @State private var isGameOver = false
    
    let moves = ["📰", "✂️", "🗿"]
    let winningMoves = ["🗿", "📰", "✂️"]
    let losingMoves = ["✂️", "🗿", "📰"]
    
    var body: some View {
        VStack {
            Spacer()
            VStack {
                if shouldWin {
                    Text(winningMoves[currentMove])
                        .font(.system(size: 100))
                        .padding()
                    Text("Win")
                        .font(.largeTitle)
                } else {
                    Text(losingMoves[currentMove])
                        .font(.system(size: 100))
                        .padding()
                    Text("Lose")
                        .font(.largeTitle)
                }
            }
            Spacer()
            Text("Score: \(score)")
            
            ForEach(0..<3) { number in
                Button {
                    moveTapped(number)
                } label: {
                    Text(moves[number])
                        .font(.system(size: 100))
                }
            }
            Spacer()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        } message: {
            Text("Your score is \(score)")
        }
        .alert("Game over", isPresented: $isGameOver) {
            Button("Play again", action: reset)
        } message: {
            Text("Your score is \(score)")
        }
    }
    
    func moveTapped(_ number: Int) {
        if number == currentMove {
            score += 1
            scoreTitle = "Yusss!"
        } else {
            scoreTitle = "Booo!"
        }
        showingScore = true
        
        if questionNumber == 10 {
            isGameOver.toggle()
        }
        print("questionNumber: \(questionNumber)")
    }
    
    func askQuestion() {
        currentMove = Int.random(in: 0...2)
        shouldWin.toggle()
        questionNumber += 1
    }
    
    func reset() {
        isGameOver.toggle()
        score = 0
        questionNumber = 1
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
