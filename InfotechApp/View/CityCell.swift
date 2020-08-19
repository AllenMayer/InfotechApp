//
//  CityCell.swift
//  InfotechApp
//
//  Created by Максим Семений on 18.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

class CityCell: UITableViewCell {
    
    static let identifier = "CityCell"
    
    private let oddCellImageLink = "https://infotech.gov.ua/storage/img/Temp1.png"
    private let evenCellImageLink = "https://infotech.gov.ua/storage/img/Temp3.png"
    
    @IBOutlet weak var cityImage: CustomImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    func configureCellAt(indexPath: IndexPath, cityName: String) {
        if indexPath.row % 2 == 0 {
            cityImage.loadImage(from: evenCellImageLink)
        } else {
            cityImage.loadImage(from: oddCellImageLink)
        }
        cityNameLabel.text = cityName
    }
    
    static func nib() -> UINib {
        return UINib(nibName: "CityCell", bundle: nil)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
}
