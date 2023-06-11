//
//  ContentView.swift
//  RockPaperScissors
//
//  Created by Diana Atas on 10/06/23.
//

import SwiftUI

struct Title: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle.bold())
            .foregroundColor(.blue)
            .padding(.all, 15)
            .background(.thinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

struct Move: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.system(size: 100))
            .padding(6)
            .shadow(color: .black, radius: 8, x: 5, y: 10)
    }
}

extension View {
    func titleStyle() -> some View {
        modifier(Title())
    }
    
    func moveStyle() -> some View {
        modifier(Move())
    }
}

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
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.teal, .clear]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack {
                Spacer()
                Text("ROCK PAPER SCISSORS")
                    .font(.headline.bold())
                    .foregroundColor(.white)
                VStack {
                    if shouldWin {
                        Text(winningMoves[currentMove])
                            .modifier(Move())
                        Text("Win")
                            .modifier(Title())
                    } else {
                        Text(losingMoves[currentMove])
                            .modifier(Move())
                        Text("Lose")
                            .modifier(Title())
                    }
                }
                .padding()
                
                Text("Score: \(score)")
                    .font(.headline)
                
                ForEach(0..<3) { number in
                    Button {
                        moveTapped(number)
                    } label: {
                        Text(moves[number])
                            .modifier(Move())
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
