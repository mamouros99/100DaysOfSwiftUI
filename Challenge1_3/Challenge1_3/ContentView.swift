//
//  ContentView.swift
//  Challenge1_3
//
//  Created by Tiago Mamouros on 09/01/2022.
//

import SwiftUI

enum GameRPS : Comparable, CaseIterable{
    case rock, paper, scissors

    static func < (lhs: Self, rhs: Self) -> Bool {
        if lhs == rhs{
            return false
        }
        else if (lhs == .rock && rhs == .paper) || (lhs == .scissors && rhs == .rock) || (lhs == .paper && rhs == .scissors){
            return true
        }
        else{
            return false
        }
    }
    
    var description: String {
        switch self {
        case .rock:
            return "rock"
        case .paper:
            return "paper"
        case .scissors:
            return "scissors"
        }
    }

}

struct ContentView: View {
    
    @State private var currentPlay: GameRPS = GameRPS.allCases.randomElement()!
    @State private var shouldPlayerWin = Bool.random()
    @State private var currentScore = 0
    
    func newPlay() -> Void {
        currentPlay = GameRPS.allCases.randomElement()!
        shouldPlayerWin = Bool.random()
    }
    
    func evaluatePlay(playersPlay: GameRPS) -> Void {
        if shouldPlayerWin && playersPlay > currentPlay {
            currentScore += 1
        }
        else if !shouldPlayerWin && playersPlay < currentPlay {
            currentScore += 1
        }
    
    }
    
    var body: some View {
        NavigationView{
            ZStack{
                Color.indigo
                    .ignoresSafeArea()
                
                VStack{
                    
                    Text("Rock Paper scissors")
                        .font(.title)
                        .bold()
                    
                    Spacer()
                    
                    
                    VStack(alignment: .leading, spacing: 4) {
                        HStack (alignment: .bottom) {
                            Text("Current Play:")
                            Image(currentPlay.description)
                        }
                        Text("Player Should: \(shouldPlayerWin ? "win" : "lose")")
                        Text("Current score \(currentScore)")
                    }
                    
                    
                    Spacer()
                    
                    HStack{
                        Spacer()
                        Button {
                            evaluatePlay(playersPlay: .rock)
                            newPlay()
                        } label: {
                            VStack(spacing: 0) {
                                Image("rock")
                                Text("Rock")
                            }
                        }

                        Spacer()
                        
                        Button {
                            evaluatePlay(playersPlay: .paper)
                            newPlay()
                        } label: {
                            VStack(spacing: 0) {
                                Image("paper")
                                Text("Paper")
                            }
                        }
                        
                        Spacer()
                        
                        Button {
                            evaluatePlay(playersPlay: .scissors)
                            newPlay()
                        } label: {
                            VStack(spacing: 0) {
                                Image("scissors")
                                Text("Scissors")
                            }
                        }
                        Spacer()
                    }
                    
                    
                    Spacer()
                    
                }
                .foregroundColor(.white)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
