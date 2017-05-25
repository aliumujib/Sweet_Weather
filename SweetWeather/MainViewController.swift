//
//  ViewController.swift
//  SweetWeather
//
//  Created by Abdul-Mujib Aliu on 5/24/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import UIKit
import ComplimentaryGradientView
class MainViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var cityModels = [City]()
    
    var cityNames = [String]()
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var whiteBottomView: UIView!
    @IBOutlet weak var citiesScrollView: UICollectionView!
    @IBOutlet weak var wetherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    
    
    func initDummyData() {
        let city1 = City()
        city1._requestName = "paris"
        city1._cityname = "Paris"
        city1._temperature = 9.0
        city1._weatherType = "Cloudy"
        
        let city2 = City()
        city2._requestName = "pisa"
        city2._cityname = "Pisa"
        city2._temperature = 29.0
        city2._weatherType = "Sunny"
        
        let city3 = City()
        city3._requestName = "rome"
        city3._cityname = "Rome"
        city3._temperature = 39.0
        city3._weatherType = "Rainy"
        
        let city4 = City()
        city4._requestName = "london"
        city4._cityname = "London"
        city4._temperature = 19.0
        city4._weatherType = "Snowy"
        
        let city5 = City()
        city5._requestName = "washington"
        city5._cityname = "Washington"
        city5._temperature = 29.0
        city5._weatherType = "Tide"
        
        let city6 = City()
        city6._requestName = "newyork"
        city6._cityname = "New York"
        city6._temperature = 29.0
        city6._weatherType = "Windy"
        
        cityModels.append(city1)
        cityModels.append(city2)
        cityModels.append(city3)
        cityModels.append(city4)
        cityModels.append(city5)
        cityModels.append(city6)

    }
    
    func setWeatherImage(city: City) {
        UIView.animate(withDuration: 0.2, animations: {
            let image = UIImage(named: "\(city.weatherType).png".lowercased())
            self.wetherImage.image = image
            let intConv = Int(city.temperature)
            self.tempLabel.text  = "\(intConv) ℃"
            self.weatherLabel.text = city.weatherType
        })
    }
    
    func moveToDetailScreen(sender : UITapGestureRecognizer){
        if let senderView = sender.view {
            print("SENDER VIEW TAG\(senderView.tag)")
            performSegue(withIdentifier: CITY_PAGE_VIEW_SEGUE_ID, sender: cityModels[senderView.tag])
        }
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == CITY_PAGE_VIEW_SEGUE_ID){
            if let detinationVC = segue.destination as? CityPageViewController{
                if let city = sender as? City{
                    detinationVC.cityToView = city
                }
            }
        }
    }
    

    override func viewDidAppear(_ animated: Bool) {
        
    }
    
    var screenheight : CGFloat!
    var screenwidth : CGFloat!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        //initDummyData()
        
        cityNames.append("Lagos")
        cityNames.append("Kano")
        cityNames.append("Paris")
        cityNames.append("Pisa")
        cityNames.append("Sokoto")
        cityNames.append("Rome")
        cityNames.append("London")
        cityNames.append("Washington")
        cityNames.append("Newyork")

        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        screenheight = self.view.frame.size.height
        screenwidth = self.view.frame.size.width

        backGroundImageView.frame = CGRect(x: 0, y: 0, width: screenwidth, height: screenheight - (screenheight/3.5))
        
        whiteBottomView.frame = CGRect(x: 0, y: backGroundImageView.frame.origin.y + backGroundImageView.frame.size.height, width: screenwidth, height: screenheight - (backGroundImageView.frame.size.height))
        
        citiesScrollView.frame = CGRect(x: 0, y: backGroundImageView.frame.origin.y+(backGroundImageView.frame.size.height) - (citiesScrollView.frame.size.height/2), width: screenwidth, height: (screenheight/5.5))
        citiesScrollView.showsHorizontalScrollIndicator = false
        citiesScrollView.backgroundView = nil
        citiesScrollView.backgroundColor = .clear
        citiesScrollView.isOpaque = false
        
        wetherImage.frame = CGRect(x: self.view.center.x - wetherImage.frame.size.width/2, y: screenwidth/6, width: screenwidth/2, height: screenwidth/2)
        
        tempLabel.frame = CGRect(x: 0, y: wetherImage.frame.origin.y + 150, width: screenwidth, height: screenwidth/2)

        weatherLabel.frame = CGRect(x: 0, y: tempLabel.frame.origin.y + 60, width: screenwidth, height: screenwidth/2)
        
        citiesScrollView.contentInset = UIEdgeInsets(top: 0, left: screenwidth/2 - 47.5 , bottom: 0, right: screenwidth/2 - 47.5)

        citiesScrollView.delegate = self
        citiesScrollView.dataSource = self
        self.citiesScrollView.decelerationRate = UIScrollViewDecelerationRateFast

        print(CITY_NAME_REQURL)
        
        for i in 0 ... cityNames.count - 1{
            var city: City = City()
            city.downLoadWeatherDetailsForCity(completed: {
                self.cityModels.append(city)
                self.citiesScrollView.reloadData()
            }, cityName: cityNames[i])
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        var visibleRect = CGRect()
        
        visibleRect.origin = citiesScrollView.contentOffset
        visibleRect.size = citiesScrollView.bounds.size
        
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        
        if let visibleIndexPath  = citiesScrollView.indexPathForItem(at: visiblePoint){
        self.setWeatherImage(city: cityModels[visibleIndexPath.row])
            
            for cell in citiesScrollView.visibleCells as! [CitiesCollectionViewCell] {
                // do something
                cell.unZoomCell()
            }
            
            
            let cell = self.citiesScrollView.cellForItem(at: visibleIndexPath) as! CitiesCollectionViewCell
            cell.zoomCell()
            
            print(visibleIndexPath)
        }else{
            
        }
    
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
            print("SENDER VIEW TAG\(indexPath.row)")
            performSegue(withIdentifier: CITY_PAGE_VIEW_SEGUE_ID, sender: cityModels[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       return cityModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CITY_PAGE_CELL_REUSE_ID, for: indexPath) as! CitiesCollectionViewCell
        
        cell.initCell(city: cityModels[indexPath.row])
        
        return cell
    }
    
    
   
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let sectionInset = citiesScrollView.contentInset
        let heightToSubtract = sectionInset.top + sectionInset.bottom
        
        return CGSize(width: 100.0, height: (self.citiesScrollView.bounds.height) - heightToSubtract)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

