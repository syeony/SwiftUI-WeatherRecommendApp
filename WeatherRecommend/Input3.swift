//
//  Input1.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/24/24.
//

import SwiftUI


struct Memo3: Identifiable, Codable {
    var id = UUID()
    var content: String
}

class MemoStore3: ObservableObject {
    @Published var memos3: [Memo3] {
        didSet {
            saveMemos3()
        }
    }

    init() {
        self.memos3 = []
        loadMemos3()
    }

    // 메모 저장 함수
    private func saveMemos3() {
        do {
            let data = try JSONEncoder().encode(memos3)
            UserDefaults.standard.set(data, forKey: "memos3")
        } catch {
            print("메모 저장 실패: \(error.localizedDescription)")
        }
    }

    // 메모 불러오기 함수
    private func loadMemos3() {
        if let data = UserDefaults.standard.data(forKey: "memos3") {
            do {
                memos3 = try JSONDecoder().decode([Memo3].self, from: data)
            } catch {
                print("메모 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }

    // 메모 삭제 함수
    func deleteMemo3(_ memo: Memo3) {
        memos3.removeAll { $0.id == memo.id }
    }
}


struct Input3: View {
    @State var todos: [String] = []
    
    @State private var newMemo3 = ""
    @ObservedObject private var memoStore3 = MemoStore3()

    
    var body: some View {
        
        VStack {
                    TextField("새로운 옷을 입력하세요", text: $newMemo3)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        saveMemo3()
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
                    requestData3()
                }
                

                Section(header: Text("내가 추가한 옷")) {
                    ForEach(memoStore3.memos3) { memo in
                        HStack {
                            Text(memo.content)
                            Spacer()
                            Button(action: {
                                // 삭제 버튼 눌렀을 때
                                memoStore3.deleteMemo3(memo)
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
    
    private func saveMemo3() {
        guard !newMemo3.isEmpty else { return }
        memoStore3.memos3.append(Memo3(content: newMemo3))
        newMemo3 = ""
    }
}

#Preview {
    Input3()
}
