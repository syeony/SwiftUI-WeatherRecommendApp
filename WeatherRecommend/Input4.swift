//
//  Input1.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/24/24.
//

import SwiftUI


struct Memo4: Identifiable, Codable {
    var id = UUID()
    var content: String
}

class MemoStore4: ObservableObject {
    @Published var memos4: [Memo4] {
        didSet {
            saveMemos4()
        }
    }

    init() {
        self.memos4 = []
        loadMemos4()
    }

    // 메모 저장 함수
    private func saveMemos4() {
        do {
            let data = try JSONEncoder().encode(memos4)
            UserDefaults.standard.set(data, forKey: "memos4")
        } catch {
            print("메모 저장 실패: \(error.localizedDescription)")
        }
    }

    // 메모 불러오기 함수
    private func loadMemos4() {
        if let data = UserDefaults.standard.data(forKey: "memos4") {
            do {
                memos4 = try JSONDecoder().decode([Memo4].self, from: data)
            } catch {
                print("메모 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }

    // 메모 삭제 함수
    func deleteMemo4(_ memo: Memo4) {
        memos4.removeAll { $0.id == memo.id }
    }
}


struct Input4: View {
    @State var todos: [String] = []
    
    @State private var newMemo4 = ""
    @ObservedObject private var memoStore4 = MemoStore4()

    
    var body: some View {
        
        VStack {
                    TextField("새로운 옷을 입력하세요", text: $newMemo4)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        saveMemo4()
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
                    requestData4()
                }
                

                Section(header: Text("내가 추가한 옷")) {
                    ForEach(memoStore4.memos4) { memo in
                        HStack {
                            Text(memo.content)
                            Spacer()
                            Button(action: {
                                // 삭제 버튼 눌렀을 때
                                memoStore4.deleteMemo4(memo)
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
    
    private func saveMemo4() {
        guard !newMemo4.isEmpty else { return }
        memoStore4.memos4.append(Memo4(content: newMemo4))
        newMemo4 = ""
    }
}

#Preview {
    Input4()
}
