//
//  Logic.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 11/30/18.
//  Copyright © 2018 Andrew Yakovenko. All rights reserved.
//

import Foundation



class Logic: NSObject {
    
     var PuzzletoWin = [[Int]]()

    func setPuzzle(size:Int) ->[[Int]] {
        var createPuzzle = 1
        var Puzzle = Array(repeating: Array(repeating: 0, count: size), count: size)
        for y in 1 ..< size {
            for x in 1 ..< size {
                Puzzle[y][x] = createPuzzle
                createPuzzle += 1
            }
        }
        return Puzzle
    }
    
    func gameEnd() -> Bool {
        
        
        
        return false
    }
    
}


