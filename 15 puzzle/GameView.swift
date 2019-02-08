//
//  GameView.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 2/3/19.
//  Copyright © 2019 Andrew Yakovenko. All rights reserved.
//

import UIKit

class GameView: UIViewController {
    
    var logic: Logic!
    
    var tileSize: CGSize!
    
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        let tileCount = 4
        
        logic = Logic(tileCount)
     
        updateMovesLable()
        
        tileSize = CGSize(width: viewPuzzles.bounds.width / CGFloat(tileCount),
                          height: viewPuzzles.bounds.height / CGFloat(tileCount))
    }
    
    private func updateMovesLable() {
        movesLable.text = "Moves: \(logic.moves)"
    }
    
    @IBAction func Play(_ sender: Any) {
        logic.startNewGame(changePuzzle: false)
        
        makeTileSubviews(inView: viewPuzzles)
        
        self.playButton.isHidden = true
    }
    
    
    // MARK: - Views
    @IBOutlet weak var viewPuzzles: UIView!
    var subViews = [(Int, UIView)]()
    
    func createTileView(frame: CGRect) -> UIView {
        let newView = UIView(frame: frame)
        newView.backgroundColor = UIColor.blue.withAlphaComponent(3.0)
        return newView
    }
    
    func makeTileSubviews(inView view: UIView) {
        guard view.frame.size.height == view.frame.size.width else {
            preconditionFailure("View for puzzle aren't square")
        }
        
        for tileIndex in 0 ..< logic.size * logic.size - 1 {
            let x = tileIndex % logic.size
            let y = tileIndex / logic.size
            
            let tileView = createTileView(frame: CGRect(origin: CGPoint(x: CGFloat(x) * tileSize.width,
                                                                        y: CGFloat(y) * tileSize.height),
                                                        size: tileSize))
            
            viewPuzzles.addSubview(tileView)
            subViews.append((tileIndex + 1, tileView))
        }
    }
    
    // MARK: - Moves
    
    @IBOutlet weak var movesLable: UILabel!
    
    @IBAction func Move(_ sender: Any) {
        guard let someSubView = self.subViews.last,
            let coordinate = self.logic.find(Coordinate: someSubView.0),
            let direction =  self.logic.getDirection(to: coordinate) else {
                return
        }
        // self.subViews.last
        UIView.animate(withDuration: 0.4) {
            self.direction(view: someSubView.1,
                           moves: direction)
            self.logic.move(cell: coordinate,
                            to: direction)
        }
    }
    
    func direction(view:UIView, moves: Logic.Directions?) {
        guard let move = moves else {
            return
        }
        
        let xlastUICoordinateOnMainView = viewPuzzles.frame.width - tileSize.width
        let ylastUICoordinateOnMainView = viewPuzzles.frame.height - tileSize.height
        
        switch move {
        case .up where view.frame.origin.y > 0:
            view.frame.origin.y -= CGFloat(tileSize.height)
            
        case .down where view.frame.origin.y < ylastUICoordinateOnMainView:
            view.frame.origin.y += CGFloat(tileSize.height)
            
        case .right where view.frame.origin.x > 0:
            view.frame.origin.x -= CGFloat(tileSize.width)
            
        case .left where view.frame.origin.x < xlastUICoordinateOnMainView:
            view.frame.origin.x += CGFloat(tileSize.width)
            
        case _:
            break
        }
    }
    
    // MARK: -
    
}
