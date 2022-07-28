//
//  WeatherManager.swift
//  Weatherify
//
//  Created by Siddhant on 16/07/22.
//

import Foundation
import CoreLocation

class WeatherManager {
    
    let API_KEY = "9d559ed51f652cfc68a10a7928141a19"
    
    func getCurrentWeather(latitude: CLLocationDegrees, longitude: CLLocationDegrees) async throws -> ResponseBody {
        guard let url  =  URL(string: "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(API_KEY)&units=metric") else {
            fatalError("Missing URL")
        }
        
        let urlRequest = URLRequest(url: url)
        
        let (data,response) =  try await URLSession.shared.data(for: urlRequest)
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            fatalError("Error fetching weather data")
        }
        do {
            let json = try JSONDecoder().decode(ResponseBody.self, from: data)
            return json
        }
        catch {
            fatalError("Unable to decode the json \(error.localizedDescription)")
        }
      
        
    }
}
