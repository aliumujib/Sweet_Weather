//
//  Constants.swift
//  SweetWeather
//
//  Created by Abdul-Mujib Aliu on 5/24/17.
//  Copyright © 2017 Abdul-Mujib Aliu. All rights reserved.
//

import Foundation

var CITY_PAGE_VIEW_CONTROLLER_STORY_BOARD_ID = "CITY_PAGE_VIEW_CONTROLLER_STORY_BOARD_ID"
var CITY_PAGE_VIEW_SEGUE_ID = "CITY_PAGE_VIEW_SEGUE_ID"
var CITY_PAGE_CELL_REUSE_ID = "CITY_PAGE_CELL_REUSE_ID"

var CITY_FORECAST_CELL_REUSE_ID = "CITY_FORECAST_CELL_REUSE_ID"

var OPEN_WEATHER_MAP_API_KEY = "8d63551d7ec886da20e252ebba9c4f01"
var CITY_NAME = "LONDON"
var BASE_URL = "http://api.openweathermap.org/data/2.5/"
var CITY_NAME_REQURL = "\(BASE_URL)weather?q=\(CITY_NAME)&appid=\(OPEN_WEATHER_MAP_API_KEY)"

var FORECAST_TO_GET = 15

//var CITY_NAME_FORCAST_URL = "\(BASE_URL)forecast/daily?q=\(CITY_NAME)&mode=json&units=metric&cnt=\(FORECAST_TO_GET)&appid=\(OPEN_WEATHER_MAP_API_KEY)"

typealias DownloadComplete = () -> ()

func getWeatherURLForCity(cityName : String) -> String {
return "\(BASE_URL)weather?q=\(cityName)&appid=\(OPEN_WEATHER_MAP_API_KEY)"
}

func getForecastURLForCity(cityName : String) -> String {
    return "\(BASE_URL)forecast/daily?q=\(cityName)&mode=json&units=metric&cnt=\(FORECAST_TO_GET)&appid=\(OPEN_WEATHER_MAP_API_KEY)"
}


var WEATHER_DICT_KEY = "weather"
var WEATHER_DICT_MAIN_KEY = "main"


var CONDITIONS_DICT_KEY = "main"
var CONDITIONS_DICT_TEMP_KEY = "temp"

var CITY_NAME_KEY = "name"

var FORECAST_LIST_KEY = "list"
var FORECAST_DATE_KEY = "dt"
var FORECAST_TEMP_DICT_KEY = "temp"
var FORECAST_TEMP_DICT_MIN_KEY = "min"
var FORECAST_TEMP_DICT_MAX_KEY = "max"

var FORECAST_WEATHER_DICT_KEY = "weather"
var FORECAST_WEATHER_DICT_MAIN_KEY = "main"
