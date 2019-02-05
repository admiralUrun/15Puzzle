//
//  GameView.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 2/3/19.
//  Copyright © 2019 Andrew Yakovenko. All rights reserved.
//

import UIKit


class GameView: UIViewController {
    var inGame = false
    var logic : Logic!
    @IBOutlet weak var movesLable: UILabel!
    @IBOutlet weak var ViewPuzzles: UIView!
    var subView : UIView!
    var subViewTwo : UIView!
    
    override func viewDidLoad() {
        self.logic = Logic(4)
        movesLable.text = "Moves: \(logic.moves)"
        self.subView = createView(at: (0,0))
        self.subViewTwo = createView(at: (75,0))
    }
    
    @IBAction func Move(_ sender: Any) {
        
        let newCGRect = getNewCGRectFor(views: (subView,subViewTwo))
        
        UIView.animate(withDuration: 0.5, animations: {
            
            self.subView.frame = newCGRect.0
            self.subViewTwo.frame = newCGRect.1
            
        })
        
    }
    
    @IBAction func Play(_ sender: Any) {
        if inGame {
            
            inGame = false
        } else {
        subView.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
        self.ViewPuzzles.addSubview(subView)
        subViewTwo.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        self.ViewPuzzles.addSubview(subViewTwo)
            inGame = true
        }
    }
    
    func createView(at coordinate:(Int,Int)) -> UIView {
        let newView = UIView(frame: CGRect(origin: .init(x: coordinate.0, y: coordinate.1),
                                           size: .init(width: 75, height: 75)))
        return newView
    }
    
    func getNewCGRectFor(views:(UIView, UIView)) -> ((CGRect, CGRect)) {
        let size = views.0.frame.size.height
        
        let firstCGRect: CGRect!
        let xFirstView = views.0.frame.origin.x
        let yFirstView = views.0.frame.origin.y
        
        let secondCGRect: CGRect!
        let xSecondView = views.1.frame.origin.x
        let ySecondView = views.1.frame.origin.y
        
        firstCGRect =  CGRect(origin: .init(x: xSecondView, y: ySecondView),
                                         size: .init(width: size, height: size))
        secondCGRect =  CGRect(origin: .init(x:xFirstView, y:yFirstView), size: .init(width: size, height: size))
        
        return(firstCGRect,secondCGRect)
    }
    
    
    
}
