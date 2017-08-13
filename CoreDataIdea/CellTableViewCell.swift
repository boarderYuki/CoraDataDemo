//
//  CellTableViewCell.swift
//  CoreDataIdea
//
//  Created by yuki.pro on 2017. 8. 13..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

class CellTableViewCell: UITableViewCell {

    @IBOutlet weak var ideaLabel: UILabel!
    @IBOutlet weak var createLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
