//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Tiago Mamouros on 05/01/2022.
//

import SwiftUI

struct ImageFlag: View {
    
    let image: String
    
    var body: some View {
        Image(image)
        .renderingMode(.original)
        .clipShape(Capsule())
        .shadow(radius: 3)
    }
}

struct Title: ViewModifier{
    
    func body(content: Content) -> some View {
        content
            .foregroundColor(.white)
            .font(.largeTitle.bold())
    }
}

extension View {
    func titleStyle() -> some View{
        modifier(Title())
    }
}

struct ContentView: View {
    
    @State var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"]
    
    @State var correctAnswer = Int.random(in: 0...2)
    
    @State private var currentScore = 0
    
    @State private var showAlert = false
    
    @State private var titleScore = ""
    
    @State private var currentQuestions = 0
        
    @State var alertMessage = ""

    @State var bool = false
    
    @State var animationRotation = [0.0,0.0,0.0]
    @State var opacity = [1.0, 1.0, 1.0]
    
    var totalQuestions = 8
    
    func flagTapped(number: Int){
        
        withAnimation(.easeInOut(duration: 2.0)) {
            animationRotation[number] += 360
        }
        
        for num in 0...2 {
            print(num)
            if num != number {
                withAnimation {
                    opacity[num] -= 0.75
                }
            }
        }
        
    
        
        if number == correctAnswer{
            titleScore = "Good Job"
            currentScore += 1
        }
        else{
            titleScore = "You suck"
        }
        
        currentQuestions += 1
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            newQuestions()
        }
        
        showAlert = true
        alertMessage = "Current Score \(currentScore)"
        
        
        if currentQuestions == totalQuestions{
            currentQuestions = 0
            titleScore = "Game Over"
            alertMessage = "Your final score is \(currentScore)"
            bool = true
        }
        
    }
    
    func newQuestions(){
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        opacity = [1.0, 1.0, 1.0]
    }

    var body: some View {
        ZStack{
            RadialGradient(stops: [
                .init(color: Color(red: 0.1, green: 0.1, blue: 0.5), location: 0.3),
                .init(color: Color(red: 0.76, green: 0.15, blue: 0.25), location: 0.3),
            ],
                           center: .top,
                           startRadius: 200,
                           endRadius: 700)
                .ignoresSafeArea()
            
            VStack {
                
                Spacer()
                
                Text("Guess The Flag")
                    .titleStyle()
                
                Spacer()
                VStack(spacing: 15){
                    
                    Spacer()
                    
                    VStack{
                        Text("Tap of the flag of")
                            .font(.subheadline.weight(.heavy))
                            .foregroundStyle( .secondary)

                        Text(countries[correctAnswer])
                            .font(.largeTitle.weight(.semibold))
                            .foregroundColor(.white)
                    }
                    
                    ForEach(0..<3){ number in
                        Button{
                            flagTapped(number: number)
                        } label: {
                            ImageFlag(image: countries[number])
                            
                        }
                        .rotation3DEffect(.degrees(animationRotation[number]), axis: (x: 0.0, y: 1.0, z: 0.0))
                        .opacity(opacity[number])
                        
                        .alert(titleScore, isPresented: $showAlert) {
                            Button("OK"){
                                if bool{
                                    bool = false
                                    currentScore = 0
                                }

                            }
                        } message: {
                            Text(alertMessage)
                        }
                        
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, maxHeight: 400)
                .padding(.vertical, 20)
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 15))
                
                Spacer()
                
                Text("Score: \(currentScore)")
                    .foregroundColor(.white)
                    .font(.headline)
            }
            .padding()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
