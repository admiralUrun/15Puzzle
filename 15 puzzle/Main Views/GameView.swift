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
    var stopWatch: StopWatch!
    var playing: Bool!
    
    var tileSize : CGSize!
    
    @IBOutlet weak var timeLable: UILabel!
    @IBOutlet weak var playButton: UIButton!
    @IBOutlet weak var viewPuzzles: UIView!
    @IBOutlet weak var movesLable: UILabel!
    var tileCount: Int! = nil
    var startDate:Date!
    typealias SubView = UIView
    
    private struct SwapingUIView {
        let first: SubView
        let second: SubView
    }
    
    // MARK: -
    override func viewDidLoad() {
        movesLable.isHidden = true
        timeLable.isHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        logic = Logic(tileCount)
        logic.preapearForNewGame()
        stopWatch = StopWatch()
        timer = Timer()
        makeTileSubviews(inView: viewPuzzles)
        playing = false
    }
    
    private func updateMovesLable() {
        movesLable.text = "Moves:\(logic.moves)"
    }
    
    // MARK:- Prepear for game
    
    public func take(size s:Int) {
        tileCount = s
    }
    
    @IBAction func Play(_ sender: Any) {
        viewPuzzles.subviews.forEach({ $0.isUserInteractionEnabled = true })
        self.playButton.isHidden = true
        movesLable.isHidden = false
        timeLable.isHidden = false
        playing = true
        mixUp()
        stopWatch.startStopWatch()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {xx -> Void in
            self.refreshLableIn()
        })
    }
    
    private func mixUp() {
        logic.moves = 0
        for row in 0 ..< logic.size {
            for col in 0 ..< logic.size {
                let coordinate = Logic.Coordinate.init(row: row, col: col)
                if theSame(f: coordinate, s: logic.emptyCell) { continue }
                let shuffingData = logic.getDirectionToShuffling(coordinate: coordinate)
                
                UIView.animate(withDuration: 0.3) {
                    self.directionFor(swap: shuffingData)
                }
            }
        }
    }
    
    private func theSame(f: Logic.Coordinate, s: Logic.Coordinate) -> Bool {
        return f.row == s.row && f.col == s.col ? true : false
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
        guard let someSubView = sender.view else { return }
        let coordinate = logic.getCoordinateBy(tag: someSubView.tag)
        let direction =  logic.getDirection(to: coordinate)
        UIView.animate(withDuration: 0.4) {
            self.direction(view: someSubView,
                           move: direction)
            self.logic.move(cell: coordinate)
        }
        updateMovesLable()
        if logic.gameEnd() {
            end(logic.moves)
        }
    }
    
    private func direction(view:UIView, move: Logic.Directions) {
        
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
            preconditionFailure("Something wrong with \(view)'s CGPoint or Directions enum was edit")
        }
    }
    
    private func directionFor(swap:Logic.ShuffelingSwap) {
        let views = SwapingUIView.init(first: findViewByTag(cellNumber: swap.firstTag),
                                      second: findViewByTag(cellNumber: swap.secondTag))
        let pointBefore = views.first.center
        views.first.center = views.second.center
        views.second.center = pointBefore
        
        self.logic.swapTwo(firstCell: logic.getCoordinateBy(tag: swap.firstTag),
                           secondCell: logic.getCoordinateBy(tag: swap.secondTag))
    }
    
    // MARK: - Game End
    
    private func end(_ move: Int) {
        // "GG, You done it for \(logic.moves) moves"
        let alert = UIAlertController(title: "GG",
                                      message: "You have done it for \(logic.moves) moves and in \(stopWatch.getTime())", preferredStyle: .alert)
        
        let playAgain = UIAlertAction(title: "Again",
                                   style: .default,
                                   handler: {xx -> Void in self.playAgain() })
        
        let toMenu = UIAlertAction(title: "Menu",
                                        style: .default,
                                        handler: {yy -> Void in self.performSegue(withIdentifier: "back",
                                                                                  sender: self)})
        alert.addAction(playAgain)
        alert.addAction(toMenu)
        present(alert, animated: true, completion: nil)
        timer.invalidate()
        print("Stop at" + stopWatch.stop())
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
    
    private func playAgain() {
        mixUp()
        updateMovesLable()
        stopWatch.startStopWatch()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: {xx -> Void in
            self.refreshLableIn()
        })
    }
    
    
    @IBAction func backButton(_ sender: Any) {
        if playing {
            self.timer.invalidate()
            print("Stop at" + self.stopWatch.stop())
            performSegue(withIdentifier: "back", sender: self)
        } else {
            performSegue(withIdentifier: "back", sender: self)
        }
    }
    
    // MARK: - Timer
    
    private func refreshLableIn() {
        timeLable.text = "Time::" + stopWatch.getTime()
    }
    
}
