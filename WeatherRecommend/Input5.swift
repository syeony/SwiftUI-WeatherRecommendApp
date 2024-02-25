//
//  Input1.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/24/24.
//

import SwiftUI


struct Memo5: Identifiable, Codable {
    var id = UUID()
    var content: String
}

class MemoStore5: ObservableObject {
    @Published var memos5: [Memo5] {
        didSet {
            saveMemos5()
        }
    }

    init() {
        self.memos5 = []
        loadMemos5()
    }

    // 메모 저장 함수
    private func saveMemos5() {
        do {
            let data = try JSONEncoder().encode(memos5)
            UserDefaults.standard.set(data, forKey: "memos5")
        } catch {
            print("메모 저장 실패: \(error.localizedDescription)")
        }
    }

    // 메모 불러오기 함수
    private func loadMemos5() {
        if let data = UserDefaults.standard.data(forKey: "memos5") {
            do {
                memos5 = try JSONDecoder().decode([Memo5].self, from: data)
            } catch {
                print("메모 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }

    // 메모 삭제 함수
    func deleteMemo5(_ memo: Memo5) {
        memos5.removeAll { $0.id == memo.id }
    }
}


struct Input5: View {
    @State var todos: [String] = []
    
    @State private var newMemo5 = ""
    @ObservedObject private var memoStore5 = MemoStore5()

    
    var body: some View {
        
        VStack {
                    TextField("새로운 옷을 입력하세요", text: $newMemo5)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        saveMemo5()
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
                    requestData5()
                }
                

                Section(header: Text("내가 추가한 옷")) {
                    ForEach(memoStore5.memos5) { memo in
                        HStack {
                            Text(memo.content)
                            Spacer()
                            Button(action: {
                                // 삭제 버튼 눌렀을 때
                                memoStore5.deleteMemo5(memo)
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
    
    private func saveMemo5() {
        guard !newMemo5.isEmpty else { return }
        memoStore5.memos5.append(Memo5(content: newMemo5))
        newMemo5 = ""
    }
}

#Preview {
    Input5()
}
