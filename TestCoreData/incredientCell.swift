//
//  incredientCell.swift
//  TestCoreData
//
//  Created by sok channy on 12/2/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import UIKit

class incredientCell: UITableViewCell {
    @IBOutlet weak var incredientLabel: UILabel!
    @IBOutlet weak var incredientSwitch: UISwitch!
    
    func configureationCell(incredient : Incredient,_ check : Bool = false) {
        incredientLabel.text = incredient.name
        incredientSwitch.isOn = check
        //incredientSwitch.isUserInteractionEnabled = false
    }
    
    var isCheck:Bool {
        set{
            incredientSwitch.isOn = newValue
        }
        get{
            return incredientSwitch.isOn
        }
    }
}
