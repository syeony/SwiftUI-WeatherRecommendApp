//
//  WeatherView.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/8/24.
//

import SwiftUI

struct WeatherView: View {
    
    @ObservedObject private var viewModel = WeatherViewModel()
    var body: some View {
        VStack {
            List{
                ForEach(viewModel.weathers, id:\.id){ weather in
                    Text(weather.title)
                }
            }
            
//            Button(action:{
//                viewModel.requestData()
//            }, label: {
//                ZStack{
//                    Capsule()
//                        .frame(width:200, height:50)
//                    Text("할일추가")
//                        .foregroundColor(.white)
//                }
//            })
        }
        .padding()
        .onAppear(){
            viewModel.requestData()
        }
    }
    
    
    
}

#Preview {
    WeatherView()
}
