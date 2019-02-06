//
//  GameView.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 2/3/19.
//  Copyright © 2019 Andrew Yakovenko. All rights reserved.
//

import UIKit

enum Moves {
    case up, down, right, left
}


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
        makeSubViews(for15Puzzle: ViewPuzzles, logicSize: Float(logic.size))
        self.playButton.isHidden = true
    }
    
    
    // MARK: - Views
    @IBOutlet weak var ViewPuzzles: UIView!
    var subViews = [UIView]()
    
    
    func createView(at coordinate:(Int,Int)) -> UIView {
        let newView = UIView(frame: CGRect(origin: .init(x: coordinate.0, y: coordinate.1),
                                           size: .init(width: 75, height: 75)))
        newView.backgroundColor = UIColor.green.withAlphaComponent(3.0)
        
        return newView
    }
    
    func makeSubViews(for15Puzzle mainView: UIView, logicSize size: Float) {
        guard mainView.frame.size.height == mainView.frame.size.width else {
            preconditionFailure("View for puzzle aren't square ")
        }
        
        var heightCoordinate = 0
        var widthCoordinate = 0
        
        for _ in 1 ... Int(size) {
            for x in 1 ... Int(size) {
                if heightCoordinate == 225 && widthCoordinate == 225 {
                    break
                }
                
                let subView = createView(at: (widthCoordinate,heightCoordinate))
                if x == Int(size)  {
                    self.ViewPuzzles.addSubview(subView)
                    self.subViews.append(subView)
                    heightCoordinate += 75
                    widthCoordinate = 0
                } else {
                    self.ViewPuzzles.addSubview(subView)
                    self.subViews.append(subView)
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
            self.direction(view: someSubView, move: .left)
        }
    }
    
    func direction(view:UIView, move: Moves) {
        switch move {
        case .up:
            view.frame.origin.y -= 75
        case .down:
            view.frame.origin.y += 75
        case .right:
            view.frame.origin.x -= 75
        case .left:
            view.frame.origin.x += 75
        }
    }
    
    // MARK: -
    
}
