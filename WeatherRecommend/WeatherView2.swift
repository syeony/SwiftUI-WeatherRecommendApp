//
//  ContentView.swift
//  NetworkingApp
//
//  Created by ohseungyeon on 2/6/24.
//

import SwiftUI

struct Todo: Decodable {
    let id: String
    let title: String
    let completed: Bool
}

struct ContentView: View {
    @State var todos: [String] = []
    @State private var isShowingAlert = false
    @State private var isAddingClothes = false
    @State private var clothesInput = ""
    
    var body: some View {
        NavigationView{
            ZStack{
                //Image("weather")
                AngularGradient(gradient: Gradient(colors: [Color.blue, Color.white]), center: .topLeading, angle: .degrees(200))
                    .ignoresSafeArea(.all)
                VStack {
                    HStack{
                        Image("Image")
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        Text("기온별 옷차림 추천")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                        Spacer()
                       

                    }
                    
                    DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    
                    
                    Button(action: {
                                isShowingAlert.toggle()
                            }, label: {
                                ZStack {
                                    Capsule()
                                        .frame(width: 200, height: 40)
                                        .foregroundColor(.yellow)
                                    Text("~28°C")
                                        .foregroundColor(.white)
                                }
                            })
                            .alert(isPresented: $isShowingAlert) {
                                Alert(
                                    title: Text("알림"),
                                    message: Text("옵션을 선택해주세요"),
                                    primaryButton: .default(Text("옷 추가하기")) {
                                        isAddingClothes = true
                                        TextField("옷을 입력하세요",text: $clothesInput)
                                            .padding()
                                            .textFieldStyle(.roundedBorder)
                                                            
                                        Button(action:{
                                            requestData2()
                                        }, label: {
                                            ZStack{
                                                Capsule()
                                                    .frame(width:200, height:40)
                                                    .foregroundColor(.orange)
                                                Text("추가")
                                                    .foregroundColor(.white)
                                            }
                                        })
                                    },
                                    secondaryButton: .default(Text("옷 보기")) {
                                        requestData1()
                                    }
                                    
                                )

                            }
                    
                    HStack{
                        Button(action:{
                            requestData2()
                        }, label: {
                            ZStack{
                                Capsule()
                                    .frame(width:200, height:40)
                                    .foregroundColor(.orange)
                                Text("27~23°C")
                                    .foregroundColor(.white)
                            }
                        })
                        
                        NavigationLink(destination: Input2()){
                            Text("추가")
                        }
                        .frame(width: 100, height: 40)
                                        .buttonStyle(PlainButtonStyle())
                                        .foregroundColor(Color.white)
                                        .padding()
                                        .background(Color("#243062"))
                                        .cornerRadius(10)
                    }
                    
                    
                    Button(action:{
                        requestData3()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.pink)
                            Text("22~20°C")
                                .foregroundColor(.white)
                        }
                    })
                    
                    Button(action:{
                        requestData4()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.red)
                            Text("19~17°C")
                                .foregroundColor(.white)
                        }
                    })
                    
                    Button(action:{
                        requestData5()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.purple)
                            Text("16~12°C")
                                .foregroundColor(.white)
                        }
                    })
                    
                    Button(action:{
                        requestData6()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.indigo)
                            Text("11~9°C")
                                .foregroundColor(.white)
                        }
                    })
                    
                    Button(action:{
                        requestData7()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.secondary)
                            Text("8~5°C")
                                .foregroundColor(.white)
                        }
                    })
                    
                    Button(action:{
                        requestData8()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.black)
                            Text("4°C~")
                                .foregroundColor(.white)
                        }
                    })
                    
                    List{
                        ForEach(todos, id:\.self){ todo in
                            Text(todo)
                        }
                    }
                }
            }
        }
        
        
    }
    
    private func requestData1(){
        requestTodo1{todo, error in
            guard let todo = todo else{
                print("todo를 받아오는데 실패")
                return
            }
            todos.append(todo.title)
        }
    }
    
    func requestTodo1(completed: @escaping(Todo?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers/1"

        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 URL입니다.")
            return
        }
        
        let task: Void = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                completed(nil,"URL에 어떤 문제가 있습니다.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "URL에서 정상적으로 응답을 받지 못했습니다.")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했습니다.")
                return
            }
            
            do{
                let responseTodo = try JSONDecoder().decode(Todo.self, from: data)
                completed(responseTodo,nil)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    private func requestData2(){
        requestTodo2{todo, error in
            guard let todo = todo else{
                print("todo를 받아오는데 실패")
                return
            }
            todos.append(todo.title)
        }
    }
    
    func requestTodo2(completed: @escaping(Todo?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers/2"

        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 URL입니다.")
            return
        }
        
        let task: Void = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                completed(nil,"URL에 어떤 문제가 있습니다.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "URL에서 정상적으로 응답을 받지 못했습니다.")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했습니다.")
                return
            }
            
            do{
                let responseTodo = try JSONDecoder().decode(Todo.self, from: data)
                completed(responseTodo,nil)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    private func requestData3(){
        requestTodo3{todo, error in
            guard let todo = todo else{
                print("todo를 받아오는데 실패")
                return
            }
            todos.append(todo.title)
        }
    }
    
    func requestTodo3(completed: @escaping(Todo?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers/3"

        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 URL입니다.")
            return
        }
        
        let task: Void = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                completed(nil,"URL에 어떤 문제가 있습니다.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "URL에서 정상적으로 응답을 받지 못했습니다.")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했습니다.")
                return
            }
            
            do{
                let responseTodo = try JSONDecoder().decode(Todo.self, from: data)
                completed(responseTodo,nil)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    private func requestData4(){
        requestTodo4{todo, error in
            guard let todo = todo else{
                print("todo를 받아오는데 실패")
                return
            }
            todos.append(todo.title)
        }
    }
    
    func requestTodo4(completed: @escaping(Todo?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers/4"

        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 URL입니다.")
            return
        }
        
        let task: Void = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                completed(nil,"URL에 어떤 문제가 있습니다.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "URL에서 정상적으로 응답을 받지 못했습니다.")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했습니다.")
                return
            }
            
            do{
                let responseTodo = try JSONDecoder().decode(Todo.self, from: data)
                completed(responseTodo,nil)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    private func requestData5(){
        requestTodo5{todo, error in
            guard let todo = todo else{
                print("todo를 받아오는데 실패")
                return
            }
            todos.append(todo.title)
        }
    }
    
    func requestTodo5(completed: @escaping(Todo?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers/5"

        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 URL입니다.")
            return
        }
        
        let task: Void = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                completed(nil,"URL에 어떤 문제가 있습니다.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "URL에서 정상적으로 응답을 받지 못했습니다.")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했습니다.")
                return
            }
            
            do{
                let responseTodo = try JSONDecoder().decode(Todo.self, from: data)
                completed(responseTodo,nil)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    private func requestData6(){
        requestTodo6{todo, error in
            guard let todo = todo else{
                print("todo를 받아오는데 실패")
                return
            }
            todos.append(todo.title)
        }
    }
    
    func requestTodo6(completed: @escaping(Todo?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers/6"

        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 URL입니다.")
            return
        }
        
        let task: Void = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                completed(nil,"URL에 어떤 문제가 있습니다.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "URL에서 정상적으로 응답을 받지 못했습니다.")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했습니다.")
                return
            }
            
            do{
                let responseTodo = try JSONDecoder().decode(Todo.self, from: data)
                completed(responseTodo,nil)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    private func requestData7(){
        requestTodo7{todo, error in
            guard let todo = todo else{
                print("todo를 받아오는데 실패")
                return
            }
            todos.append(todo.title)
        }
    }
    
    func requestTodo7(completed: @escaping(Todo?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers/7"

        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 URL입니다.")
            return
        }
        
        let task: Void = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                completed(nil,"URL에 어떤 문제가 있습니다.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "URL에서 정상적으로 응답을 받지 못했습니다.")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했습니다.")
                return
            }
            
            do{
                let responseTodo = try JSONDecoder().decode(Todo.self, from: data)
                completed(responseTodo,nil)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    private func requestData8(){
        requestTodo8{todo, error in
            guard let todo = todo else{
                print("todo를 받아오는데 실패")
                return
            }
            todos.append(todo.title)
        }
    }
    
    func requestTodo8(completed: @escaping(Todo?, String?)->()){
        let endPoint = "https://65c22e19f7e6ea59682acdff.mockapi.io/weathers/8"

        guard let url = URL(string: endPoint) else {
            completed(nil, "잘못된 URL입니다.")
            return
        }
        
        let task: Void = URLSession.shared.dataTask(with: url){data, response, error in
            if let _ = error{
                completed(nil,"URL에 어떤 문제가 있습니다.")
                return
            }
            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else{
                completed(nil, "URL에서 정상적으로 응답을 받지 못했습니다.")
                return
            }
            guard let data = data else{
                completed(nil, "데이터를 받지 못했습니다.")
                return
            }
            
            do{
                let responseTodo = try JSONDecoder().decode(Todo.self, from: data)
                completed(responseTodo,nil)
            } catch{
                print(error)
            }
        }.resume()
    }
    
    
}

#Preview {
    ContentView()
}
