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
    var timer: Timer!
    
    var tileSize : CGSize!
    
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var viewPuzzles: UIView!
    @IBOutlet weak var movesLable: UILabel!
    var tileCount: Int! = nil
    var startDate:Date!
    
    // MARK: -
    override func viewDidLoad() {
        movesLable.isHidden = true
        timeLable.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        logic = Logic(tileCount)
        logic.preapearForNewGame()
        makeTileSubviews(inView: viewPuzzles)
    }
    
    private func updateMovesLable() {
        movesLable.text = "Moves:\(logic.moves)"
    }
    
    // MARK:- Prepear for game
    
    public func take(size s:Int) {
        tileCount = s
    }
    
    
    @IBAction func Play(_ sender: Any) {
        viewPuzzles.subviews.forEach({$0.isUserInteractionEnabled = true})
        self.playButton.isHidden = true
        movesLable.isHidden = false
        timeLable.isHidden = false
        mixUp()
        startDate = Date()
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {xx -> Void in
            self.refreshLableIn(time: xx)
            print("Tick")
        })
        
    }
    
   private func mixUp() {
    logic.moves = 0
        for _ in  0 ... 1000    {
            if let directionAndCellTagWithCoordinate = logic.getDataForMixUp(),
                let direction = directionAndCellTagWithCoordinate.0 {
                
                let view = findViewByTag(cellNumber: directionAndCellTagWithCoordinate.1)
                UIView.animate(withDuration: 0.3) {
                    self.direction(view: view,
                                   moves: direction)
                    self.logic.mix(cell: directionAndCellTagWithCoordinate.2 ,
                                    to: direction)
                }
            } else {
                continue
            }
        }
        
        while logic.puzzle.last?.last != tileCount * tileCount {
            if let directionAndCellTagWithCoordinate = logic.getDataForMixUp(),
                let direction = directionAndCellTagWithCoordinate.0 {
                
                let view = findViewByTag(cellNumber: directionAndCellTagWithCoordinate.1)
                UIView.animate(withDuration: 0.3) {
                    self.direction(view: view,
                                   moves: direction)
                    self.logic.mix(cell: directionAndCellTagWithCoordinate.2 ,
                                    to: direction)
                }
            } else {
                continue
            }
        }
    }
    
    // MARK: - Views
    
   private func createTileView(frame: CGRect, index: Int) -> UIImageView {
        let newView = UIImageView(frame: frame)
        newView.tag = index + 1
        let image = UIImage(named: "\(newView.tag)")
        newView.image = image
        
        return newView
    }
    
   private func makeTileSubviews(inView view: UIView) {
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
    
   private func findViewByTag(cellNumber:Int) -> UIView {
        for subView in viewPuzzles.subviews {
            if subView.tag == cellNumber {
                return subView
            }
        }
        preconditionFailure("I don't found view with tag \(cellNumber)")
    }
    
    // MARK: - Moves
    
    @objc func catchTapOnView(_ sender: UITapGestureRecognizer) {
        guard let someSubView = sender.view,
            let coordinate = logic.getCoordinateBy(tag: someSubView.tag),
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
        updateMovesLable()
        if logic.gameEnd() {
            end(logic.moves)
        }
    }
    
   private func direction(view:UIView, moves: Logic.Directions?) {
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
    
    // MARK: - Game End
    
    private func end(_ move: Int) {
        // "GG, You done it for \(logic.moves) moves"
        let alert = UIAlertController(title: "GG",
                                      message: "You done it for \(logic.moves) moves and \(timeInString())", preferredStyle: .alert)
        
        let newOne = UIAlertAction(title: "Again",
                                   style: .default,
                                   handler: {xx -> Void in self.starNewGame() })
        
        let stopPlaying = UIAlertAction(title: "Menu",
                                        style: .default,
                                        handler: {yy -> Void in self.performSegue(withIdentifier: "back", sender: self)})
        
        alert.addAction(newOne)
        alert.addAction(stopPlaying)
        present(alert, animated: true, completion: nil)
    }
    
    private func starNewGame() {
        logic = Logic(tileCount)
        logic.preapearForNewGame()
        makeTileSubviews(inView: viewPuzzles)
        
        viewPuzzles.subviews.forEach({$0.isUserInteractionEnabled = true})
        self.playButton.isHidden = true
        movesLable.isHidden = false
        timeLable.isHidden = false
        mixUp()
    }
    
    
    // MARK: - Timer
    
    private func refreshLableIn(time: Timer) {
        timeLable.text = "Time::" + timeInString()
    }
    
    private func timeInString() -> String {
        let seconds = Date().timeIntervalSinceReferenceDate - startDate.timeIntervalSinceReferenceDate
        let hours = Int(seconds / 3600)
        let mitets = Int(seconds / 60)
        return "\(hours):\(mitets):\(Int(seconds))"
    }
    
}
