//
//  Input1.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/24/24.
//

import SwiftUI


struct Memo1: Identifiable, Codable {
    var id = UUID()
    var content: String
}

class MemoStore1: ObservableObject {
    @Published var memos1: [Memo1] {
        didSet {
            saveMemos1()
        }
    }

    init() {
        self.memos1 = []
        loadMemos1()
    }

    // 메모 저장 함수
    private func saveMemos1() {
        do {
            let data = try JSONEncoder().encode(memos1)
            UserDefaults.standard.set(data, forKey: "memos1")
        } catch {
            print("메모 저장 실패: \(error.localizedDescription)")
        }
    }

    // 메모 불러오기 함수
    private func loadMemos1() {
        if let data = UserDefaults.standard.data(forKey: "memos1") {
            do {
                memos1 = try JSONDecoder().decode([Memo1].self, from: data)
            } catch {
                print("메모 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }

    // 메모 삭제 함수
    func deleteMemo1(_ memo: Memo1) {
        memos1.removeAll { $0.id == memo.id }
    }
}


struct Input1: View {
    @State var todos: [String] = []
    
    @State private var newMemo1 = ""
    @ObservedObject private var memoStore1 = MemoStore1()

    
    var body: some View {
        
        VStack {
                    TextField("새로운 옷을 입력하세요", text: $newMemo1)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        saveMemo1()
                    }, label: {
                        ZStack {
                            Capsule()
                                .frame(width: 200, height: 40)
                                .foregroundColor(.orange)
                            Text("입력한 옷 추가")
                                .foregroundColor(.white)
                        }
                    })
            
            List {
                Section(header: Text("추천 옷")) {
                    ForEach(todos, id: \.self) { todo in
                        Text(todo)
                    }
                }
                .onAppear(){
                    requestData1()
                }
                

                Section(header: Text("내가 추가한 옷")) {
                    ForEach(memoStore1.memos1) { memo in
                        HStack {
                            Text(memo.content)
                            Spacer()
                            Button(action: {
                                // 삭제 버튼 눌렀을 때
                                memoStore1.deleteMemo1(memo)
                            }) {
                                Image(systemName: "trash")
                                    .foregroundColor(.red)
                            }
                        }
                    }
                }
            }
            


                }
                .padding()
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
    
    private func saveMemo1() {
        guard !newMemo1.isEmpty else { return }
        memoStore1.memos1.append(Memo1(content: newMemo1))
        newMemo1 = ""
    }
}

#Preview {
    Input1()
}
