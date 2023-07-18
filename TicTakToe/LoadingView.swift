//
//  LoadingView.swift
//  TicTacToe
//
//  Created by Inesh Sekar on 18/07/23.
//
import SwiftUI

struct LoadingView: View {
    @State private var selectedPlayingStyle = 0
    @State private var isLoading = false
    
    var body: some View {
        VStack {
            Text("Loading")
                .font(.largeTitle)
                .padding()
            
            ActivityIndicator(isAnimating: $isLoading)
                .frame(width: 50, height: 50)
            
            Picker(selection: $selectedPlayingStyle, label: Text("Playing Style")) {
                Text("Easy").tag(0)
                Text("Hard").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            
            Button(action: {
                startGame()
            }) {
                Text("Start Game")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
        .onAppear {
            isLoading = true
            simulateLoadingProcess()
        }
    }
    
    func simulateLoadingProcess() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            isLoading = false
        }
    }
    
    func startGame() {
        // Pass the selected playing style to the game view
        let gameView = GameView(playingStyle: selectedPlayingStyle == 0 ? .easy : .hard)
        // Present the game view
        // You can use a navigation controller or a sheet to present the game view
        // For example, using a sheet:
        // presentationMode.wrappedValue.dismiss()
    }
}
