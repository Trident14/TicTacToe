//
//  GameViewModel.swift
//  TicTacToe
//
//  Created by Inesh Sekar on 18/07/23.
//

import SwiftUI

final class GameViewModel:ObservableObject{
    let column:[GridItem]=[GridItem(.flexible()),
                           GridItem(.flexible()),
                           GridItem(.flexible())]
    
    @Published var moves:[Move?] = Array(repeating: nil, count: 9)
    @Published  var isGameActive=false;
    @Published var alertItem: AlertItem?
 
    
    
    func processPlayerMove(for position:Int){
          if isTaken(in: moves, forIndex: position){return}
          moves[position]=Move(player: .human,BoardIdx: position)
         
          //check win or draw
          if checkWin(for: .human, in: moves){
              alertItem=AlertContext.humanWin
              return
          }
          
          if checkDraw(in:moves){
              alertItem=AlertContext.Draw
              return
          }
          isGameActive=true
          
          DispatchQueue.main.asyncAfter(deadline:.now()+0.5){ [self] in
              let computerPos=computerMove(in: moves)
              moves[computerPos]=Move(player: .computer,BoardIdx: computerPos)
              isGameActive=false
              
              if(checkWin(for: .computer, in: moves)){
                  alertItem=AlertContext.computerWin
                  return
              }
              if checkDraw(in:moves){
                  alertItem=AlertContext.Draw
                  return
              }
              
          }
      }
      
    
    func isTaken(in moves:[Move?],forIndex index:Int)->Bool{
        return moves.contains(where: {$0?.BoardIdx==index})
    }
    func findWinningMove(for player: Move, in moves: [Move?]) -> Int? {
        // Define all possible winning combinations
        let winningCombinations: [[Int]] = [
            [0, 1, 2], [3, 4, 5], [6, 7, 8], // Rows
            [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
            [0, 4, 8], [2, 4, 6] // Diagonals
        ]
        
        // Check each winning combination
        for combination in winningCombinations {
            let positions = combination.map { moves[$0] }
            
            // If two positions in the combination are occupied by the player, find the empty position
            if positions.filter({ $0?.player == player.player }).count == 2,
               let emptyPosition = positions.firstIndex(where: { $0 == nil }) {
                return combination[emptyPosition]
            }
        }
        
        return nil // No winning move found
    }
    
    func computerMove(in moves: [Move?]) -> Int {
        // Check if the computer can win in the next move
        if let winningMove = findWinningMove(for: Move(player: .computer, BoardIdx: 0), in: moves) {
            return winningMove
        }
        
        // Check if the player can win in the next move and block them
        if let blockingMove = findWinningMove(for: Move(player: .human, BoardIdx: 0), in: moves) {
            return blockingMove
        }
        
        // Generate a random move that is not in a winning position for the player
        var newPosition = Int.random(in: 0..<9)
        while isTaken(in: moves, forIndex: newPosition) || checkWin(for: .human, in:moves) {
            newPosition = Int.random(in: 0..<9)
        }
        
        return newPosition
    }
    
    
    func checkWin(for player:Player,in moves:[Move?])->Bool{
        let winPat:Set<Set<Int>>=[[0,1,2],[3,4,5],[6,7,8],
                                  [0,3,6],[1,4,7],[2,5,8],
                                  [0,4,8],[2,4,6]]
        
        
        //removes all nil
        let playerMove = moves.compactMap{ $0 }.filter{ $0.player==player}
        
        //get all the player pos like winPat
        let playerPos = Set(playerMove.map {$0.BoardIdx})
        
        
        for pattern in winPat where pattern.isSubset(of: playerPos){return true}
        
        return false
    }
    
    func checkDraw(in moves:[Move?])->Bool{
        return moves.compactMap{$0}.count == 9
    }
    
    func resetGame(){
        moves=Array(repeating: nil, count: 9);
    }
    
}
