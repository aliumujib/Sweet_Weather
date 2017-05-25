//
//  CityPageViewController.swift
//  SweetWeather
//
//  Created by Abdul-Mujib Aliu on 5/24/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import UIKit
import Alamofire

class CityPageViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var backGroundImageView: UIImageView!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var weatherLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var foreCastTableView: UITableView!
    
    var screenheight : CGFloat!
    var screenwidth : CGFloat!
    
    var minHeight: CGFloat = 0.0
    var maxHeight: CGFloat!
    
    var previousScrollOffset : CGFloat = 0.0
    var headerHeightConstant: CGFloat!
    
    var cityToView: City!
    var foreCasts = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if let barBtnItem = self.navigationController?.navigationBar.topItem{
            barBtnItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        }

        // Do any additional setup after loading the view.
        
        screenheight = self.view.frame.size.height
        screenwidth = self.view.frame.size.width
        
        backGroundImageView.frame = CGRect(x: 0, y: 0, width: screenwidth, height: screenheight - (screenheight/2.3))
        
        let navBarY = (self.navigationController?.navigationBar.frame.origin.y)! + 10
        
        weatherImage.frame = CGRect(x: self.view.center.x - weatherImage.frame.size.width/2, y: navBarY , width: screenwidth/2, height: screenwidth/2)
        
        tempLabel.frame = CGRect(x: 0, y: weatherImage.frame.origin.y + weatherImage.frame.size.height + 10 , width: screenwidth , height: 50)
        
        weatherLabel.frame = CGRect(x: 0, y: weatherLabel.frame.origin.y + 150, width: screenwidth, height: 40)
        
        weatherLabel.frame = CGRect(x: 0, y: tempLabel.frame.origin.y + 60, width: screenwidth, height: 40)
        
        dateLabel.frame = CGRect(x: 0, y: weatherLabel.frame.origin.y + weatherLabel.frame.size.height, width: screenwidth, height: 40)
        
        foreCastTableView.frame = CGRect(x: 0, y: backGroundImageView.frame.origin.y + backGroundImageView.frame.size.height, width: screenwidth, height: screenheight - backGroundImageView.frame.size.height)
        
        foreCastTableView.delegate = self
        foreCastTableView.dataSource = self
        
        
        maxHeight = backGroundImageView.frame.size.height
        self.headerHeightConstant = self.maxHeight
        
        if(cityToView != nil){
            self.title = cityToView.cityname
            let todaysDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let dateFormat = dateFormatter.string(from: todaysDate)
            self.dateLabel.text = dateFormat
            initWeather(city: cityToView)
            
            downloadForeCastDataForCity(completed: {
                self.foreCastTableView.reloadData()
            }, cityName: cityToView.cityname.replacingOccurrences(of: " ", with: ""))
        }
        
        

    }
    
    
    func downloadForeCastDataForCity(completed: @escaping DownloadComplete, cityName: String) {
        if let forcastURL = URL(string: getForecastURLForCity(cityName: cityName)){
        
        Alamofire.request(forcastURL).responseJSON{
            response in
            let result = response.result
            
            if let entireDict = result.value as? Dictionary<String,AnyObject>{
                if let forcastList = entireDict[FORECAST_LIST_KEY] as? [Dictionary<String, AnyObject>]{
                    if(!forcastList.isEmpty){
                        for obj in forcastList{
                            var forecast = Forecast(weatherDict: obj)
                            self.foreCasts.append(forecast)
                            
                        }
                    }
                    
                    completed()
                }
                
            
            }
            
            }
        }
    }
    
    //BAD DRY
    func initWeather(city: City) {
        
            let image = UIImage(named: "\(city.weatherType).png".lowercased())
            self.weatherImage.image = image
            let intConv = Int(city.temperature)
            self.tempLabel.text  = "\(intConv) ℃"
            self.weatherLabel.text = city.weatherType
        
    }
    
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
        let absoluteTop: CGFloat = 0;
        let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
        
        let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
        let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
        //
        // Will implement header height logic here next
        //
        self.previousScrollOffset = scrollView.contentOffset.y
        
        var newHeight = self.headerHeightConstant
        if isScrollingDown {
            newHeight = max(self.minHeight, self.headerHeightConstant - abs(scrollDiff))
        } else if isScrollingUp {
            newHeight = min(self.maxHeight, self.headerHeightConstant + abs(scrollDiff))
        }
        
        if newHeight != self.headerHeightConstant {
            self.headerHeightConstant = newHeight
        }
        
        print("HEADER HEIGHT \(newHeight)")
        
        let range = self.maxHeight - self.minHeight
        let openAmount = self.headerHeightConstant - self.minHeight
        backGroundImageView.frame = CGRect(x: backGroundImageView.frame.origin.x, y: backGroundImageView.frame.origin.y, width: screenwidth, height: openAmount)
        
        foreCastTableView.frame = CGRect(x: 0, y: backGroundImageView.frame.origin.y + backGroundImageView.frame.size.height, width: screenwidth, height: screenheight - backGroundImageView.frame.size.height)
        
        print("\(openAmount)")
        let percentage = openAmount / range
        self.weatherLabel.alpha = percentage

        
    }
    
    



    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foreCasts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CITY_FORECAST_CELL_REUSE_ID, for: indexPath) as! ForecastCollectionViewCell
        
        cell.initForecast(foreCast: foreCasts[indexPath.row])
        
        
        
        //cell.textLabel!.text = "Cell \(indexPath.row)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 67.0
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
