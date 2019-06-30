//
//  Logic.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 12/4/18.
//  Copyright © 2018 Andrew Yakovenko. All rights reserved.
//

import Foundation

class Logic: NSObject {
    
    public enum Directions {
        case up, down, right, left
    }
    
    struct ShuffelingSwap {
        let frist: Directions
        let firstTag: CellTag
        let second: Directions
        let secondTag: CellTag
    }
    
    struct Coordinate {
        var row: Int
        var col: Int
    }
    
    public let size: Int
    
    init(_ size: Int) {
        self.size = size
    }
    
    typealias Map = [[Int]]
    typealias CellTag = Int
    
    var emptyCell = Coordinate.init(row: 0, col: 0)
    var moves = 0
    
    // MARK: - Star Game logic
    
    var puzzle = Map()
    var toWinPuzzle = Map()
    
    private func puzzleSet(size:Int) -> Map {
        var puzzleNumbers = 1
        var puzzle = Array(repeating: Array(repeating: 0, count: size), count: size)
        for x in 0 ..< size {
            for y in 0 ..< size {
                puzzle[x][y] = puzzleNumbers
                puzzleNumbers += 1
            }
        }
        return puzzle
    }
    
    public func preapearForNewGame()  {
        emptyCell = Coordinate.init(row: size - 1, col: size - 1)
        moves = 0
        puzzle = puzzleSet(size: size)
        toWinPuzzle = puzzle
    }
    
    public func gameEnd() -> Bool {
        return puzzle == toWinPuzzle
    }
    
    // MARK: - Check Direction and move
    
    public func getCoordinateBy(tag cellTag: CellTag) -> Coordinate {
        for row in 0 ..< size {
            for col in 0 ..< size {
                if puzzle[row][col] == cellTag {
                    return Coordinate.init(row: row, col: col)
                }
            }
        }
        preconditionFailure("There is not cell with tag \(cellTag) ! ! !")
    }
    
    public func getDirection(to cell: Coordinate) -> Directions {
        if cell.row > size || cell.col > size || cell.col < 0 || cell.row < 0 {
            preconditionFailure("Your Coordinate is nil")
        }
        
        let directions = [(-1, 0), (0, -1), (1, 0), (0, 1)]
        
        for direction in directions {
            let xN = cell.row + direction.0
            let yN = cell.col + direction.1
            
            if (xN < 0 || xN == size || yN < 0 || yN == size) {
                continue
            }
            
            if puzzle[xN][yN] == puzzle[emptyCell.row][emptyCell.col] {
                switch direction {
                case (-1, 0) :
                    return Directions.up
                case (0, -1):
                    return Directions.right
                case (1, 0):
                    return Directions.down
                case (0, 1):
                    return Directions.left
                default:
                    preconditionFailure("Something go wrong")
                }
            }
        }
        preconditionFailure("Something go wrong")
    }
    
    public func getDirectionToShuffling(coordinate cell:Coordinate) -> ShuffelingSwap {
        
        let directions = [(-1, 0), (0, -1), (1, 0), (0, 1)]
        var shuffing = [Directions]()
        for direction in directions {
            let xN = cell.row + direction.0
            let yN = cell.col + direction.1
            
            if (xN < 0 || xN == size || yN < 0 || yN == size || (xN, yN) == (emptyCell.row, emptyCell.col)) {
                continue
            }
            
            switch direction {
            case (-1, 0) :
                shuffing.append(Directions.up)
            case (0, -1):
                shuffing.append(Directions.right)
            case (1, 0):
                shuffing.append(Directions.down)
            case (0, 1):
                shuffing.append(Directions.left)
            default: break
                
            }
        }
        
        let first = shuffing[Int.random(in: 0 ..< shuffing.count)]
        let secondTag = puzzle[cell.row][cell.col]
        switch first {
        case .up:
            return ShuffelingSwap.init(frist: first, firstTag: puzzle[cell.row - 1][cell.col],
                                       second: .down, secondTag: secondTag)
        case .down:
            return ShuffelingSwap.init(frist: first, firstTag: puzzle[cell.row + 1][cell.col],
                                       second: .up, secondTag: secondTag)
        case .right:
            return ShuffelingSwap.init(frist: first, firstTag: puzzle[cell.row][cell.col - 1],
                                       second: .left, secondTag: secondTag)
        case .left:
            return ShuffelingSwap.init(frist: first, firstTag: puzzle[cell.row][cell.col + 1],
                                       second: .right, secondTag: secondTag)
        }
    }
    
    public func swapTwo(firstCell f: Coordinate, secondCell s: Coordinate)  {
        let cellForSwap = puzzle[f.row][f.col]
        puzzle[f.row][f.col] = puzzle[s.row][s.col]
        puzzle[s.row][s.col] = cellForSwap
    }
    
    public func move(cell: Coordinate?) {
        guard let _ = cell else { preconditionFailure("There isn't cell a coodinate \(cell!)") }
        change(to: cell!)
        moves += 1
    }
    
    private func change(to cell: Coordinate) {
        let secondCoordinate = cell
        let empty = puzzle[emptyCell.row][emptyCell.col]
        
        puzzle[emptyCell.row][emptyCell.col] = puzzle[secondCoordinate.row][secondCoordinate.col]
        puzzle[secondCoordinate.row][secondCoordinate.col] = empty
        
        emptyCell = cell
    }
    
}
