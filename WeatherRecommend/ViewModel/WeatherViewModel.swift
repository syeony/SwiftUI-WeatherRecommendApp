//
//  WeatherViewModel.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/8/24.
//

import Foundation

class WeatherViewModel: ObservableObject{
    @Published var weathers = [Weather]()

    func requestData(){
        NetworkManager.shared.requestWeather{ resWeathers, error in
            guard let resWeathers = resWeathers else{
                print("Todo를 받아오는데 실패했습니다.")
                return
            }
            self.weathers = resWeathers
        }
    }
}
