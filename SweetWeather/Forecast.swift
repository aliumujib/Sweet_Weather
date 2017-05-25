//
//  Forecast.swift
//  SweetWeather
//
//  Created by Abdul-Mujib Aliu on 5/25/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import Foundation
import Alamofire

class Forecast {
    
    var _date: String!
    var _weatherType: String!
    var _highTemp: String!
    var _lowTemp: String!
    
    var date: String{
        if(_date == nil){
            _date = ""
        }
        
        return _date
    }
    
    var weatherType: String{
        if(_weatherType == nil){
            _weatherType = ""
        }
        
        return _weatherType
    }
    
    var highTemp: String{
        if(_highTemp == nil){
            _highTemp = ""
        }
        
        return _highTemp
    }
    
    var lowTemp: String{
        if(_lowTemp == nil){
            _lowTemp = ""
        }
        
        return _lowTemp
    }
    
    init(weatherDict: Dictionary<String, Any>) {
        if let date = weatherDict[FORECAST_DATE_KEY] as? Float{
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .none
         self._date =  dateFormatter.string(from: Date(timeIntervalSince1970: TimeInterval(date)))
            print(self._date)
            
        }
        if let temperatures = weatherDict[FORECAST_TEMP_DICT_KEY] as? Dictionary<String, AnyObject>{
            if let minimumTemp = temperatures[FORECAST_TEMP_DICT_MIN_KEY] as? Float{
                let intConv = Int(minimumTemp)
                self._lowTemp = "\(intConv)℃"
                print(self._lowTemp)
            }
            
            if let maximumTemp = temperatures[FORECAST_TEMP_DICT_MAX_KEY] as? Float{
                let intConv = Int(maximumTemp)
                self._highTemp = "\(intConv)℃"
                print(self._highTemp)
            }
        }
        if let weatherDetailsDict = weatherDict[FORECAST_WEATHER_DICT_KEY] as? [Dictionary<String, AnyObject>]{
            if let weatherType = weatherDetailsDict[0][FORECAST_WEATHER_DICT_MAIN_KEY] as? String{
                self._weatherType = weatherType
                print(self._weatherType)
            }
            
        }
    }
}

