//
//  MenuViewController.swift
//  15 puzzle
//
//  Created by Andrew Yakovenko on 6/9/19.
//  Copyright © 2019 Andrew Yakovenko. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    
    var gameSize = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func threeSizeGame(_ sender: Any) {
        gameSize = 3
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
    
    @IBAction func fourSizeGmae(_ sender: Any) {
        gameSize = 4
        performSegue(withIdentifier: "gameSegue", sender: self)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let game = segue.destination as! GameView
        game.take(size: gameSize)
    }

}
