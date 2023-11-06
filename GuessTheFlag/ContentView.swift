//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Önder Atakan Önder on 6.11.2023.
//

import SwiftUI

struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "America", "Turkey", "Azerbaijan", "Isreal", "Germany", "Switzerland", "Italy", "Philippines"].shuffled()
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    @State private var scoreTitle = ""
    @State private var scoreNumber: Int = 0
    
    var body: some View {
        ZStack {
            //MARK: ARKA PLAN RENGİ
            RadialGradient(stops: [
                .init(color: .orange, location: 0.3),
                .init(color: .yellow, location: 0.3)],
                           center: .top, startRadius: 200, endRadius: 700)
            .ignoresSafeArea()
            //MARK: METİNLER VE KUTULAR
            VStack {
                Spacer()
                Text("Guess The Flag")
                    .foregroundStyle(.white)
                    .font(.largeTitle.bold())
                VStack (spacing:15){
                    VStack {
                        Text("Tap the flag")
                            .foregroundStyle(.gray)
                            .font(.title2.bold())
                        Text(countries[correctAnswer])
                            .font(.title.weight(.semibold))
                            .foregroundStyle(.black)
                    }
                    ForEach(0..<3) { number in
                        Button {flagTapped(number)
                        } label: {
                            Image(countries[number])
                                .resizable()
                                .scaledToFit()
                                .clipShape(.circle)
                                .shadow(radius: 10)
                                
                                //.scaledToFit()
                        }
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)
                .background(.regularMaterial)
                .clipShape(.rect(cornerRadius: 20))
                
                Spacer()
                Spacer()
                
                Text("Score: \(scoreNumber)")
                    .foregroundStyle(.white)
                    .font(.title.bold())
                Spacer()
            }
            .padding()
        }
        .alert(scoreTitle, isPresented: $showingScore) {
            Button("Continue", action: askQuestion)
        }
        
    }
        
        
        func flagTapped(_ number : Int) {
            if number == correctAnswer {
                scoreTitle = "Correct"
            } else {
                scoreTitle = "Wrong"
            }
            showingScore = true
        }
        
        func askQuestion() {
            countries.shuffle()
            correctAnswer = Int.random(in: 0...2)
        }
    
    func scoreLabel(_ number: Int) {
        if number == correctAnswer {
                     scoreNumber += 1
        } else {
            scoreNumber -= 1
        }
    }
    }

#Preview {
    ContentView()
}
