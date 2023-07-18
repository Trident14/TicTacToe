//
//  move.swift
//  TicTakToe
//
//  Created by Inesh Sekar on 18/07/23.
//
import Foundation

enum Player{
    case human, computer
}

struct Move{
    let player: Player
    let BoardIdx: Int
    
    var indicator: String{
        switch player {
            case .human:
                return "xmark"
            case .computer:
                return "circle"
        }
    }
    
}
