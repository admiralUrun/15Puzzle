//
//  GameView.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 2/3/19.
//  Copyright © 2019 Andrew Yakovenko. All rights reserved.
//

import UIKit

class GameView: UIViewController {
    // MARK: - Game Logic
    var inGame = false
    var logic: Logic!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        self.logic = Logic(4)
        movesLable.text = "Moves: \(logic.moves)"
    }
    
    @IBAction func Play(_ sender: Any) {
        logic.startNewGame(changePuzzle: false)
        makeSubViews(for15Puzzle: ViewPuzzles, logicSize: Float(logic.size))
        self.playButton.isHidden = true
    }
    
    
    // MARK: - Views
    @IBOutlet weak var ViewPuzzles: UIView!
    var subViews = [(Int, UIView)]()
    
    func createView(at coordinate:(Int,Int)) -> UIView {
        let newView = UIView(frame: CGRect(origin: .init(x: coordinate.0, y: coordinate.1),
                                           size: .init(width: 75, height: 75)))
        
        newView.backgroundColor = UIColor.blue.withAlphaComponent(3.0)
        
        return newView
    }
    
    func makeSubViews(for15Puzzle mainView: UIView, logicSize size: Float) {
        guard mainView.frame.size.height == mainView.frame.size.width else {
            preconditionFailure("View for puzzle aren't square ")
        }
        
        var heightCoordinate = 0
        var widthCoordinate = 0
        
        var viewNumber = 1
        
        for _ in 1 ... Int(size) {
            for x in 1 ... Int(size) {
                // TODO: cheange to nubemrs to view frame
                if heightCoordinate == 225 && widthCoordinate == 225 {
                    break
                }
                
                let subView = createView(at: (widthCoordinate,heightCoordinate))
                if x == Int(size)  {
                    self.ViewPuzzles.addSubview(subView)
                    self.subViews.append((viewNumber, subView))
                    viewNumber += 1
                    heightCoordinate += 75
                    widthCoordinate = 0
                } else {
                    self.ViewPuzzles.addSubview(subView)
                    self.subViews.append((viewNumber, subView))
                    viewNumber += 1
                    widthCoordinate += 75
                }
            }
        }
    }
    
    
    // MARK: - Moves
    
    @IBOutlet weak var movesLable: UILabel!
    
    @IBAction func Move(_ sender: Any) {
        guard let someSubView = ViewPuzzles.subviews.last else {
            return
        }
        
        UIView.animate(withDuration: 0.5) {
            
            self.direction(view: someSubView, moves: self.logic.getDirection(emptyCell: self.logic.emptyCell, to: self.logic.find(Coordinate: 15), changeLogic: true) )
          //  self.logic.change(emptyCell: self.logic.emptyCell, to: self.logic.find(Coordinate: 15) )
        }
    }
    
    // TODO: cheange to nubemrs to view frame
    
    func direction(view:UIView, moves: Logic.Directions?) {
        guard let move = moves else {
            return
        }
        
        switch move {
        case .up:
            if view.frame.origin.y <= 0 {
                return
            } else {
                view.frame.origin.y -= 75
            }
        case .down:
            if view.frame.origin.y >= 225 {
                return
            } else {
                view.frame.origin.y += 75
            }
        case .right:
            if view.frame.origin.x <= 0 {
                return
            } else {
                view.frame.origin.x -= 75
            }
        case .left:
            if view.frame.origin.x >= 225 {
                return
            } else {
                view.frame.origin.x += 75
            }
        }
    }
    
    // MARK: -
    
}
