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
    
    var tileSize : CGSize!
    
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var playButton: UIButton!
    
    override func viewDidLoad() {
        let tileCount = 4
        logic = Logic(tileCount)
        movesLable.isHidden = true
        timeLable.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        logic.preapearForNewGame()
        makeTileSubviews(inView: viewPuzzles)
    }
    
    private func updateMovesLable() {
        movesLable.text = "Moves: \(logic.moves)"
    }
    
    // MARK:- Prepear for game
    
    @IBAction func Play(_ sender: Any) {
        viewPuzzles.subviews.forEach({$0.isUserInteractionEnabled = true})
        self.playButton.isHidden = true
        movesLable.isHidden = false
        timeLable.isHidden = false
        mixUp()
    }
    
    func mixUp() {
        for _ in  0 ... 1000    {
            if let directionAndCellTagWithCoordinate = logic.getDirectionForMixUp(),
                let direction = directionAndCellTagWithCoordinate.0 {
                
                let view = findViewByTag(cellNumber: directionAndCellTagWithCoordinate.1)
                UIView.animate(withDuration: 0.3) {
                    self.direction(view: view,
                                   moves: direction)
                    self.logic.move(cell: directionAndCellTagWithCoordinate.2 ,
                                    to: direction)
                }
            } else {
                continue
            }
        }
        
        while logic.puzzle.last?.last != 16 {
            if let directionAndCellTagWithCoordinate = logic.getDirectionForMixUp(),
                let direction = directionAndCellTagWithCoordinate.0 {
                
                let view = findViewByTag(cellNumber: directionAndCellTagWithCoordinate.1)
                UIView.animate(withDuration: 0.3) {
                    self.direction(view: view,
                                   moves: direction)
                    self.logic.move(cell: directionAndCellTagWithCoordinate.2 ,
                                    to: direction)
                }
            } else {
                continue
            }
        }
        
    }
    
    // MARK: - Views
    
    @IBOutlet weak var viewPuzzles: UIView!
    
    func createTileView(frame: CGRect, index: Int) -> UIImageView {
        let newView = UIImageView(frame: frame)
        newView.tag = index + 1
        let image = UIImage(named: "\(newView.tag)")
        newView.image = image
        return newView
    }
    
    func makeTileSubviews(inView view: UIView) {
        guard view.frame.size.height == view.frame.size.width else {
            preconditionFailure("View for puzzle aren't square")
        }
        tileSize = CGSize(width: viewPuzzles.bounds.width / CGFloat(logic.size),
                          height: viewPuzzles.bounds.height / CGFloat(logic.size))
        
        for tileIndex in 0 ..< logic.size * logic.size - 1 {
            let x = tileIndex % logic.size
            let y = tileIndex / logic.size
            
            let tileView = createTileView(frame: CGRect(origin: CGPoint(x: CGFloat(x) * tileSize.width,
                                                                        y: CGFloat(y) * tileSize.height),
                                                        size: tileSize), index: tileIndex)
            
            
            let tapOnView = UITapGestureRecognizer(target: self, action: #selector(self.catchTapOnView(_:)))
            tileView.addGestureRecognizer(tapOnView)
            tileView.isUserInteractionEnabled = false
            viewPuzzles.addSubview(tileView)
        }
    }
    
    func findViewByTag(cellNumber:Int) -> UIView {
        for subView in viewPuzzles.subviews {
            if subView.tag == cellNumber {
                return subView
            }
        }
        preconditionFailure("I don't found view with tag \(cellNumber)")
    }
    
    // MARK: - Moves
    
    @IBOutlet weak var movesLable: UILabel!
    
    @objc func catchTapOnView(_ sender: UITapGestureRecognizer) {
        updateMovesLable()
        guard let someSubView = sender.view,
            let coordinate = logic.find(Coordinate: someSubView.tag),
            let direction =  logic.getDirection(to: coordinate)
            else {
                return
        }
        UIView.animate(withDuration: 0.4) {
            self.direction(view: someSubView,
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
