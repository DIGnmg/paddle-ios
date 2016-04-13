//
//  PlayerVCViewController.swift
//  Paddle
//
//  Created by Nathanael Gethers on 4/8/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class PlayerVC: UIViewController {

    var labelText = ""
    
    convenience init(player: Player){
        self.init(nibName: "PlayerVC", bundle: nil)
        labelText = player.firstName
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: NSBundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
