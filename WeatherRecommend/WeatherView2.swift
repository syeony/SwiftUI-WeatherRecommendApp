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
    
    @State private var isShowingAlert1 = false
    @State private var isShowingAlert2 = false
    @State private var isShowingAlert3 = false
    @State private var isShowingAlert4 = false
    @State private var isShowingAlert5 = false
    @State private var isShowingAlert6 = false
    @State private var isShowingAlert7 = false
    @State private var isShowingAlert8 = false
    
    @State private var isAddingClothes = false
    @State private var clothesInput = ""
    @State private var navigate1 = false
    @State private var navigate2 = false
    @State private var navigate3 = false
    @State private var navigate4 = false
    @State private var navigate5 = false
    @State private var navigate6 = false
    @State private var navigate7 = false
    @State private var navigate8 = false
    
    var body: some View {
        NavigationView{
            ZStack{
                //Image("weather")
                AngularGradient(gradient: Gradient(colors: [Color.blue, Color.white]), center: .topLeading, angle: .degrees(200))
                    .ignoresSafeArea(.all)
                VStack {
                    HStack{
                        Spacer()
                        Image("Image")
                            .resizable()
                            .clipShape(Circle())
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                        
                        Text("오늘 뭐 입지?")
                            .font(.title)
                            .fontWeight(.bold)
                            .foregroundColor(Color.black)
                            .multilineTextAlignment(.leading)
                        Spacer()
                       

                    }
                    
                    DatePicker(selection: /*@START_MENU_TOKEN@*/.constant(Date())/*@END_MENU_TOKEN@*/, label: { /*@START_MENU_TOKEN@*/Text("Date")/*@END_MENU_TOKEN@*/ })
                    
                    
                    Button(action: {
                                isShowingAlert1.toggle()
                            }, label: {
                                ZStack {
                                    Capsule()
                                        .frame(width: 200, height: 40)
                                        .foregroundColor(.yellow)
                                    Text("~28°C")
                                        .foregroundColor(.white)
                                }
                            })
                            .alert(isPresented: $isShowingAlert1) {
                                Alert(
                                    title: Text("알림"),
                                    message: Text("옵션을 선택해주세요"),
                                    primaryButton: .default(Text("내 옷장 보기")) {
                                        navigate1 = true
                                    },
                                    secondaryButton: .default(Text("추천 옷 보기")) {
                                        requestData1()
                                    }
                                    
                                )

                            }
                            .background(
                                NavigationLink(
                                    destination: Input1(), // 이동할 목적지 뷰
                                    isActive: $navigate1, // 네비게이션 상태 바인딩
                                    label: EmptyView.init // 실제로 보이지 않는 뷰
                                )
                            )
                    
                    
                    Button(action:{
                        isShowingAlert2.toggle()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.orange)
                            Text("27~23°C")
                                .foregroundColor(.white)
                        }
                    })
                    .alert(isPresented: $isShowingAlert2) {
                        Alert(
                            title: Text("알림"),
                            message: Text("옵션을 선택해주세요"),
                            primaryButton: .default(Text("내 옷장 보기")) {
                                navigate2 = true
                            },
                            secondaryButton: .default(Text("추천 옷 보기")) {
                                requestData2()
                            }
                            
                        )

                    }
                    .background(
                        NavigationLink(
                            destination: Input2(), // 이동할 목적지 뷰
                            isActive: $navigate2, // 네비게이션 상태 바인딩
                            label: EmptyView.init // 실제로 보이지 않는 뷰
                        )
                    )
                    
                    
                    Button(action:{
                        isShowingAlert3.toggle()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.pink)
                            Text("22~20°C")
                                .foregroundColor(.white)
                        }
                    })
                    .alert(isPresented: $isShowingAlert3) {
                        Alert(
                            title: Text("알림"),
                            message: Text("옵션을 선택해주세요"),
                            primaryButton: .default(Text("내 옷장 보기")) {
                                navigate3 = true
                            },
                            secondaryButton: .default(Text("추천 옷 보기")) {
                                requestData3()
                            }
                            
                        )

                    }
                    .background(
                        NavigationLink(
                            destination: Input3(), // 이동할 목적지 뷰
                            isActive: $navigate3, // 네비게이션 상태 바인딩
                            label: EmptyView.init // 실제로 보이지 않는 뷰
                        )
                    )
                    
                    Button(action:{
                        isShowingAlert4.toggle()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.red)
                            Text("19~17°C")
                                .foregroundColor(.white)
                        }
                    })
                    .alert(isPresented: $isShowingAlert4) {
                        Alert(
                            title: Text("알림"),
                            message: Text("옵션을 선택해주세요"),
                            primaryButton: .default(Text("내 옷장 보기")) {
                                navigate4 = true
                            },
                            secondaryButton: .default(Text("추천 옷 보기")) {
                                requestData4()
                            }
                            
                        )

                    }
                    .background(
                        NavigationLink(
                            destination: Input4(), // 이동할 목적지 뷰
                            isActive: $navigate4, // 네비게이션 상태 바인딩
                            label: EmptyView.init // 실제로 보이지 않는 뷰
                        )
                    )
                    
                    Button(action:{
                        isShowingAlert5.toggle()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.purple)
                            Text("16~12°C")
                                .foregroundColor(.white)
                        }
                    })
                    .alert(isPresented: $isShowingAlert5) {
                        Alert(
                            title: Text("알림"),
                            message: Text("옵션을 선택해주세요"),
                            primaryButton: .default(Text("내 옷장 보기")) {
                                navigate5 = true
                            },
                            secondaryButton: .default(Text("추천 옷 보기")) {
                                requestData5()
                            }
                            
                        )

                    }
                    .background(
                        NavigationLink(
                            destination: Input5(), // 이동할 목적지 뷰
                            isActive: $navigate5, // 네비게이션 상태 바인딩
                            label: EmptyView.init // 실제로 보이지 않는 뷰
                        )
                    )
                    
                    Button(action:{
                        isShowingAlert6.toggle()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.indigo)
                            Text("11~9°C")
                                .foregroundColor(.white)
                        }
                    })
                    .alert(isPresented: $isShowingAlert6) {
                        Alert(
                            title: Text("알림"),
                            message: Text("옵션을 선택해주세요"),
                            primaryButton: .default(Text("내 옷장 보기")) {
                                navigate6 = true
                            },
                            secondaryButton: .default(Text("추천 옷 보기")) {
                                requestData6()
                            }
                            
                        )

                    }
                    .background(
                        NavigationLink(
                            destination: Input6(), // 이동할 목적지 뷰
                            isActive: $navigate6, // 네비게이션 상태 바인딩
                            label: EmptyView.init // 실제로 보이지 않는 뷰
                        )
                    )
                    
                    Button(action:{
                        isShowingAlert7.toggle()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.secondary)
                            Text("8~5°C")
                                .foregroundColor(.white)
                        }
                    })
                    .alert(isPresented: $isShowingAlert7) {
                        Alert(
                            title: Text("알림"),
                            message: Text("옵션을 선택해주세요"),
                            primaryButton: .default(Text("내 옷장 보기")) {
                                navigate7 = true
                            },
                            secondaryButton: .default(Text("추천 옷 보기")) {
                                requestData7()
                            }
                            
                        )

                    }
                    .background(
                        NavigationLink(
                            destination: Input7(), // 이동할 목적지 뷰
                            isActive: $navigate7, // 네비게이션 상태 바인딩
                            label: EmptyView.init // 실제로 보이지 않는 뷰
                        )
                    )
                    
                    Button(action:{
                        isShowingAlert8.toggle()
                    }, label: {
                        ZStack{
                            Capsule()
                                .frame(width:200, height:40)
                                .foregroundColor(.black)
                            Text("4°C~")
                                .foregroundColor(.white)
                        }
                    })
                    .alert(isPresented: $isShowingAlert8) {
                        Alert(
                            title: Text("알림"),
                            message: Text("옵션을 선택해주세요"),
                            primaryButton: .default(Text("내 옷장 보기")) {
                                navigate8 = true
                            },
                            secondaryButton: .default(Text("추천 옷 보기")) {
                                requestData8()
                            }
                            
                        )

                    }
                    .background(
                        NavigationLink(
                            destination: Input8(), // 이동할 목적지 뷰
                            isActive: $navigate8, // 네비게이션 상태 바인딩
                            label: EmptyView.init // 실제로 보이지 않는 뷰
                        )
                    )
                    
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
