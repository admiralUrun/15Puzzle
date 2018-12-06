//
//  Logic.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 12/4/18.
//  Copyright © 2018 Andrew Yakovenko. All rights reserved.
//

import Foundation

class Logic: NSObject {
    
    var Puzzle = [[Int]]()
    var toWinPuzzle = [[Int]]()
    var size = 4
    var emptyCell = (3, 3)
    
    func puzzleSet(size:Int) ->[[Int]] {
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
    
    func startNewGame()  {
        toWinPuzzle = puzzleSet(size: size)
        Puzzle = puzzleSet(size: size)
        toWinPuzzle = puzzleSet(size: size)
        var firstCell = 0
        var secondCell = 0
        
        for _ in 1 ..< 1000 {
            firstCell = Int.random(in: 1 ... 15)
            secondCell = Int.random(in: 1 ... 15)
            
            firstCell == secondCell ? reRollRandom(firstCell: firstCell) : changeCells(firstCell: firstCell, secondCell: secondCell)
            
            print(Puzzle)
        }
    }
    
    func reRollRandom(firstCell:Int) {
        
        for _ in 1 ..< 1000 {
           let secondCell = Int.random(in: 1 ... 15)
            if firstCell != secondCell {
                changeCells(firstCell: firstCell, secondCell: secondCell)
                return
            }
        }
    }
    
    func changeCells(firstCell:Int , secondCell:Int) {
        var firstXY = findCordinate(Cell: firstCell)
        var secondXY = findCordinate(Cell: secondCell)
        
        
        let second = Puzzle[firstXY.0][firstXY.1]
        Puzzle[firstXY.0][firstXY.1] = Puzzle[secondXY.0][secondXY.1]
        Puzzle[secondXY.0][secondXY.1] = second
        
    }
    
    
    func findCordinate(Cell number:Int) -> (Int, Int) {
       var xy = (0, 0)
        for y in 1 ..< size {
            for x in 1 ..< size {
                if Puzzle[y][x] == number {
                    xy = (y, x)
                    return xy
                }
            }
        }
        return xy
    }
    
    func editPuzzle(cellEmpty:(Int,Int)) {
        
        
        
        
    }
    
    
    func gameEnd() -> Bool {
        
        return false
    }
}
