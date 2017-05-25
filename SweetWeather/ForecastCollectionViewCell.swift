//
//  ForecastCollectionViewCell.swift
//  SweetWeather
//
//  Created by Abdul-Mujib Aliu on 5/25/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UITableViewCell {
    
    @IBOutlet weak var foreCastIcon: UIImageView!
    
    @IBOutlet weak var forecastDay: UILabel!
    
    @IBOutlet weak var foreCastWetherTypeLabel: UILabel!
    
    @IBOutlet weak var highTempLabel: UILabel!
    
    @IBOutlet weak var lowtempLabel: UILabel!
    
    
    override func awakeFromNib() {
        let screenWidth : CGFloat = self.frame.size.width
        
        foreCastIcon.frame = CGRect(x: 10, y: 10, width: 45, height: 46)
        forecastDay.frame = CGRect(x: foreCastIcon.frame.origin.x + foreCastIcon.frame.size.width + 10, y: 10, width: screenWidth - 65, height: 21)
         foreCastWetherTypeLabel.frame = CGRect(x: foreCastIcon.frame.origin.x + foreCastIcon.frame.size.width + 10, y: 30, width: screenWidth - 65, height: 21)
        highTempLabel.frame = CGRect(x: screenWidth - 75, y: 10, width: 60, height: 21)
        
        lowtempLabel.frame = CGRect(x: screenWidth - 75, y: 30, width: 60, height: 21)
    }
    
    func initForecast(foreCast : Forecast){
     var weatherImage = UIImage(named: "\(foreCast.weatherType).png".lowercased())
        foreCastIcon.image = weatherImage
        forecastDay.text = foreCast.date
        foreCastWetherTypeLabel.text = foreCast.weatherType
        highTempLabel.text = foreCast.highTemp
        lowtempLabel.text = foreCast.lowTemp
    }
    
}
