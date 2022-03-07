//
//  RestaurantCell.swift
//  BottleRocket
//
//  Created by Jamescy on 3/6/22.
//

import UIKit

class RestaurantCell: UICollectionViewCell {
    
    static let identifier = "RestaurantCell"
    
    @IBOutlet private weak var restaurantNameLabel: UILabel!
    @IBOutlet private weak var categoryTypeLabel: UILabel!
    @IBOutlet private weak var restaurantImageView: UIImageView!
    
    func configureCell( restaurantName: String, categoryType: String, imageData: Data){
        restaurantNameLabel.text = restaurantName
        categoryTypeLabel.text = categoryType
        restaurantImageView.image = UIImage(data: imageData)
    }
    
}
