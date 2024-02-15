//
//  NetworkManager.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/8/24.
//

import Foundation

class NetworkManager{
    static let shared = NetworkManager()
    
    private init (){}
    
    
    func requestWeather(completed: @escaping ([Weather]?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers" //고치기
        
        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 url")
            return
        }
        
        let task = URLSession.shared.dataTask(with:url){data, response, error in
            if error != nil{
                completed(nil, "url에 문제가 있음")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode==200 else{
                completed(nil, "URL에서 응답없음")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했다!")
                return
            }
            
            do{
                let decodedWeather=try JSONDecoder().decode([Weather].self, from: data) //고치기
                completed(decodedWeather, nil) //고치기
            } catch{
                print(error)
            }
        }
        task.resume()
    }
}
