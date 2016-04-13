//
//  Player.swift
//  Paddle
//
//  Created by Nathanael Gethers on 4/7/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class Player: NSObject {
    private var _firstName: String!
    private var _lastName: String!
    
    var firstName: String {
        get {
            return _firstName
        }
    }
    
    var lastName: String {
        get {
            return _lastName
        }
    }
    
    init(firstName:String, lastName:String) {
        self._firstName = firstName
        self._lastName = lastName
    }
}
