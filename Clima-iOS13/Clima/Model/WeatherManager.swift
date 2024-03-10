//
//  WeatherManager.swift
//  Clima
//
//  Created by 김도연 on 12/27/23.
//  Copyright © 2023 App Brewery. All rights reserved.
//
// openweatherMap api key = c9c0a88bcf2383274ec6ed261c9968f5

import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didUpdateWeather(_ weatherManager: WeatherManager, _ weather: WeatherModel)
    func didFailWithError(error: Error)
}

struct WeatherManager {
    var weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=c9c0a88bcf2383274ec6ed261c9968f5&units=metric"
    
    var delegate: WeatherManagerDelegate?
    
    func fetchWeather(cityName: String) {
        var urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(with: urlString)
    }
    
    func fetchWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) {
        var urlString = "\(weatherURL)&lat=\(latitude)&lon=\(longitude)"
        performRequest(with: urlString)
    }
    
    // url 생성하는 함수들을 따로 둠 -- 위에 두개
    // url갖고 base 주소에서 서치 조건에 따라서 url에 리퀘 요청하는 함수
    // 뷰컨에서 웨더매니저에서 받은 정보를 갖고 뷰를 그려야해서 델리게이트 패턴을 씀?
    func performRequest(with urlString: String) {
        // 1. create a URL
        if let url = URL(string: urlString) {
            // 2. create a URLSession
            let session = URLSession(configuration: .default)
            // 3. give the session a task
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let weather = self.parseJSON(safeData) {
                        let weatherVC = WeatherViewController()
                        self.delegate?.didUpdateWeather(self, weather)
                    }
                }
            }
            // 4. start the task
            task.resume()
        }
    }
    
    func parseJSON(_ weatherData: Data) -> WeatherModel?{
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            let id = decodedData.weather[0].id
            let temp = decodedData.main.temp
            let name = decodedData.name
            
            let weather = WeatherModel(conditionId: id, cityName: name, temperature: temp)
            return weather
        } catch {
            self.delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
