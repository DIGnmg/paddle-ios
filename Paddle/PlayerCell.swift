//
//  PlayerTableCell.swift
//  Paddle
//
//  Created by Nathanael Gethers on 4/11/16.
//  Copyright © 2016 dignmg. All rights reserved.
//

import UIKit

class PlayerCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(text:String){
        cellLabel.text = text
    }
    
}
