//
//  GameView.swift
//  TicTakToe
//
//  Created by Inesh Sekar on 18/07/23.
//

import SwiftUI

struct GameView: View {

    @StateObject private var viewModel=GameViewModel()
    
    var body: some View {
        GeometryReader{geomerty in
            VStack{
                Spacer()
                LazyVGrid(columns:viewModel.column,  spacing: 4){
                    ForEach(0..<9) { i in
                        ZStack{
                            GameCircleView(proxy: geomerty)
                            
                            //if moves[i] is Nill then ""  else we display correct symobol
                            PlayerIndicator(systemImageName: viewModel.moves[i]?.indicator ?? "")
                        }
                        .onTapGesture {
                            viewModel.processPlayerMove(for: i)
                        }
                    }
                }
                Spacer()
            }
            .disabled(viewModel.isGameActive)
            .padding()
            .alert(item: $viewModel.alertItem, content: {alertItem in
                Alert(title: alertItem.title,message: alertItem.message,
                      dismissButton: .default(alertItem.buttonTitle,action: {
                    viewModel.resetGame()
                }))
            })
        }
    }
   
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        GameView()
            
    }
}

struct GameCircleView: View {
    var proxy:GeometryProxy
    var body: some View {
        Circle()
            .foregroundColor(Color("primary")).opacity(0.5)
            .frame(width: proxy.size.width/3 - 10 ,
                   height: proxy.size.width/3 - 10)
    }
}

struct PlayerIndicator: View {
    var systemImageName:String
    var body: some View {
        Image(systemName:systemImageName)
            .resizable()
            .frame(width: 40,height: 40)
            .foregroundColor(Color("secondary"))
    }
}
