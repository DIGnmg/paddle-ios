//
//  Player.swift
//  Paddle
//
//  Created by Nathanael Gethers on 4/7/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class Player: NSObject {
    private var _name = "Player"
    
    var name: String {
        get {
            return _name
        }
    }
    
    init(name:String) {
        self._name = name
    }
}
