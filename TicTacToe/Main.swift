//
//  Main.swift
//  TicTacToe
//
//  Created by Inesh Sekar on 18/07/23.
//

import SwiftUI

struct Main: View {
    var body: some View {
        NavigationView {
                ZStack{
                    Image("bg")
                        .resizable()
                        .scaledToFill()
                        .edgesIgnoringSafeArea(.all)
                    VStack{
                        Text("Grid Conquest").bold()
                        .font(.system(size: 50))
                        .foregroundColor(.black)
                        .padding()
                    NavigationLink(destination: GameView()) {
                        Text("Play")
                            .font(.largeTitle)
                            .fontDesign(.serif)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                       
                    }
                }
            }
        }
      
    }
}

struct Main_Previews: PreviewProvider {
    static var previews: some View {
        Main()
    }
}
