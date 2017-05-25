//
//  City.swift
//  SweetWeather
//
//  Created by Abdul-Mujib Aliu on 5/24/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import Foundation
import Alamofire

public class City {
    var _cityname: String!
    var _weatherType: String!
    var _temperature: Float!
    var _requestName: String!
    
    var cityname: String{
        if _cityname == nil{
            _cityname = ""
        }
        return _cityname
    }
    

    
    var weatherType: String{
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var requestName: String{
        if _requestName == nil{
            _requestName = ""
        }
        return _requestName
    }
    
    var temperature: Float{
        if _temperature == nil{
            _temperature = 0.0
        }
        return _temperature
    }
    
    func downLoadWeatherDetailsForCity(completed: @escaping DownloadComplete, cityName: String) {
        let currentWeatherURL  = URL(string: CITY_NAME_REQURL)!
        Alamofire.request(getWeatherURLForCity(cityName: cityName)).responseJSON{ response in

            let result = response
            
            if let entireDict = result.value as? Dictionary<String, Any> {
                
                if let cityNameStr = entireDict[CITY_NAME_KEY] as? String{
                    self._cityname = cityNameStr.capitalized
                    self._requestName = cityNameStr.lowercased().replacingOccurrences(of: " ", with: "")
                }
                
                if let weathDict = entireDict[WEATHER_DICT_KEY] as? [Dictionary<String, Any>]{
                    if(!weathDict.isEmpty){
                    if let weatherType = weathDict[0][WEATHER_DICT_MAIN_KEY] as? String{
                        self._weatherType = weatherType.capitalized
                        }
                    }
                }
                
                if let mainDict = entireDict[CONDITIONS_DICT_KEY] as? Dictionary<String, Any>{
                    if let weatherTemp = mainDict[CONDITIONS_DICT_TEMP_KEY] as? Float{
                        var toCelcius = weatherTemp - 273
                        self._temperature = toCelcius
                        
                    }
                }
            
            print(result)
            
        }
        
        completed()
    }
    
    
    }
}
