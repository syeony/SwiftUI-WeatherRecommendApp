//
//  ContentView.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/8/24.
//

import SwiftUI

struct TodoView: View {
    
    @ObservedObject private var viewModel = TodoViewModel()
    var body: some View {
        VStack {
            List{
                ForEach(viewModel.todos, id:\.id){ todo in
                    Text(todo.title)
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
    TodoView()
}
