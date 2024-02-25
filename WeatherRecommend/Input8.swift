//
//  Input1.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/24/24.
//

import SwiftUI


struct Memo8: Identifiable, Codable {
    var id = UUID()
    var content: String
}

class MemoStore8: ObservableObject {
    @Published var memos8: [Memo8] {
        didSet {
            saveMemos8()
        }
    }

    init() {
        self.memos8 = []
        loadMemos8()
    }

    // 메모 저장 함수
    private func saveMemos8() {
        do {
            let data = try JSONEncoder().encode(memos8)
            UserDefaults.standard.set(data, forKey: "memos8")
        } catch {
            print("메모 저장 실패: \(error.localizedDescription)")
        }
    }

    // 메모 불러오기 함수
    private func loadMemos8() {
        if let data = UserDefaults.standard.data(forKey: "memos8") {
            do {
                memos8 = try JSONDecoder().decode([Memo8].self, from: data)
            } catch {
                print("메모 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }

    // 메모 삭제 함수
    func deleteMemo8(_ memo: Memo8) {
        memos8.removeAll { $0.id == memo.id }
    }
}


struct Input8: View {
    @State var todos: [String] = []
    
    @State private var newMemo8 = ""
    @ObservedObject private var memoStore8 = MemoStore8()

    
    var body: some View {
        
        VStack {
                    TextField("새로운 옷을 입력하세요", text: $newMemo8)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        saveMemo8()
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
                    requestData8()
                }
                

                Section(header: Text("내가 추가한 옷")) {
                    ForEach(memoStore8.memos8) { memo in
                        HStack {
                            Text(memo.content)
                            Spacer()
                            Button(action: {
                                // 삭제 버튼 눌렀을 때
                                memoStore8.deleteMemo8(memo)
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
    
    private func saveMemo8() {
        guard !newMemo8.isEmpty else { return }
        memoStore8.memos8.append(Memo8(content: newMemo8))
        newMemo8 = ""
    }
}

#Preview {
    Input8()
}
