//
//  CitiesCollectionViewCell.swift
//  SweetWeather
//
//  Created by Abdul-Mujib Aliu on 5/25/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import UIKit

class CitiesCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityImage: UIImageView!
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var contentWrapper: UIView!
    
    @IBInspectable var cornerRadius: CGFloat = 2
    
    @IBInspectable var shadowOffsetWidth: Int = 0
    @IBInspectable var shadowOffsetHeight: Int = 2
    @IBInspectable var shadowColor: UIColor? = UIColor.black
    @IBInspectable var shadowOpacity: Float = 0.3
    
    override func awakeFromNib() {
        let view = self
       
        contentWrapper.backgroundColor = .white
        contentWrapper.frame = CGRect(x:  10 , y:10 , width: 95 , height: 105)
        contentWrapper.layer.cornerRadius = cornerRadius
        let shadowPath = UIBezierPath(roundedRect: contentWrapper.bounds, cornerRadius: cornerRadius)
        
        contentWrapper.layer.masksToBounds = false
        contentWrapper.layer.shadowColor = shadowColor?.cgColor
        contentWrapper.layer.shadowOffset = CGSize(width: shadowOffsetWidth, height: shadowOffsetHeight);
        contentWrapper.layer.shadowOpacity = shadowOpacity
        contentWrapper.layer.shadowPath = shadowPath.cgPath
        
        cityImage.frame = CGRect(x: 10 , y: 10, width: 74 , height: 64)
        cityImage.contentMode = .scaleAspectFit
        
        cityName.numberOfLines = 1
        cityName.textAlignment = .center
        cityName.frame = CGRect(x:  -5 , y:cityImage.frame.origin.y + cityImage.frame.size.height, width:view.frame.size.width , height: 30)
        cityName.isHidden = false
    
    }
    
    func zoomCell()  {
        UIView.animate(withDuration: 0.2, animations: {
            
            self.contentWrapper.backgroundColor = .white
            self.contentWrapper.frame = CGRect(x:  0 , y:10 , width: 105 , height: 115)
            self.contentWrapper.layer.cornerRadius = self.cornerRadius
            let shadowPath = UIBezierPath(roundedRect: self.contentWrapper.bounds, cornerRadius: self.cornerRadius)
            
            self.contentWrapper.layer.masksToBounds = false
            self.contentWrapper.layer.shadowColor = self.shadowColor?.cgColor
            self.contentWrapper.layer.shadowOffset = CGSize(width: self.shadowOffsetWidth, height: self.shadowOffsetHeight);
            self.contentWrapper.layer.shadowOpacity = self.shadowOpacity
            self.contentWrapper.layer.shadowPath = shadowPath.cgPath
            self.cityImage.frame = CGRect(x: 10 , y: 10, width: 84 , height: 74)
            self.cityImage.contentMode = .scaleAspectFit
            
            self.cityName.numberOfLines = 1
            self.cityName.textAlignment = .center
            self.cityName.frame = CGRect(x:  0 , y:self.cityImage.frame.origin.y + self.cityImage.frame.size.height, width:self.frame.size.width , height: 30)
            self.cityName.isHidden = false
            
        })

    }
    
    
    func unZoomCell()  {
        UIView.animate(withDuration: 0.2, animations: {
            self.contentWrapper.backgroundColor = .white
            self.contentWrapper.frame = CGRect(x:  10 , y:10 , width: 95 , height: 105)
            self.contentWrapper.layer.cornerRadius = self.cornerRadius
            let shadowPath = UIBezierPath(roundedRect: self.contentWrapper.bounds, cornerRadius: self.cornerRadius)
            
            self.contentWrapper.layer.masksToBounds = false
            self.contentWrapper.layer.shadowColor = self.shadowColor?.cgColor
            self.contentWrapper.layer.shadowOffset = CGSize(width: self.shadowOffsetWidth, height: self.shadowOffsetHeight);
            self.contentWrapper.layer.shadowOpacity = self.shadowOpacity
            self.contentWrapper.layer.shadowPath = shadowPath.cgPath
            
            self.cityImage.frame = CGRect(x: 10 , y: 10, width: 74 , height: 64)
            self.cityImage.contentMode = .scaleAspectFit
            
            self.cityName.numberOfLines = 1
            self.cityName.textAlignment = .center
            self.cityName.frame = CGRect(x:  -5 , y:self.cityImage.frame.origin.y + self.cityImage.frame.size.height, width:self.frame.size.width , height: 30)
            self.cityName.isHidden = false
        })
        
    }

    
    func initCell(city : City)  {
        let image = UIImage(named: "\(city.requestName).png")
        cityImage?.image = image
        cityName?.text = city.cityname.replacingOccurrences(of: "_", with: " ").capitalized
        print("Added imageView \(city.requestName)")
    }
    
}
