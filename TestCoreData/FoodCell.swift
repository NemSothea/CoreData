//
//  FoodCell.swift
//  TestCoreData
//
//  Created by sok channy on 12/1/16.
//  Copyright © 2016 channy-origin. All rights reserved.
//

import UIKit

class FoodCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var price: UILabel!    
    @IBOutlet weak var foodImage: UIImageView!
    
    func configuration(food:Food){
        
        
        self.title.text = food.name
        self.price.text = "\(food.price) $"
        foodImage.image = food.toImage?.image as? UIImage
    }
}
