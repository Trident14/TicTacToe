//
//  Alert.swift
//  TicTacToe
//
//  Created by Inesh Sekar on 18/07/23.
//

import SwiftUI

struct AlertItem:Identifiable{
    let id=UUID()
    var title:Text
    var message:Text
    var buttonTitle:Text
}
struct AlertContext{
    static let humanWin = AlertItem(title: Text("You Win!"),
                                    message: Text("Ai Defeated"),
                                    buttonTitle: Text("Reset "))
    
    
    static let computerWin = AlertItem(title: Text("You Lost!"),
                                       message: Text("Ai Won"),
                                       buttonTitle: Text("Reset"))
    
    static  let Draw = AlertItem(title: Text("Draw!"),
                                 message: Text("retry"),
                                 buttonTitle: Text("Reset "))
}
