//
//  Input1.swift
//  WeatherRecommend
//
//  Created by ohseungyeon on 2/24/24.
//

import SwiftUI


struct Memo6: Identifiable, Codable {
    var id = UUID()
    var content: String
}

class MemoStore6: ObservableObject {
    @Published var memos6: [Memo6] {
        didSet {
            saveMemos6()
        }
    }

    init() {
        self.memos6 = []
        loadMemos6()
    }

    // 메모 저장 함수
    private func saveMemos6() {
        do {
            let data = try JSONEncoder().encode(memos6)
            UserDefaults.standard.set(data, forKey: "memos6")
        } catch {
            print("메모 저장 실패: \(error.localizedDescription)")
        }
    }

    // 메모 불러오기 함수
    private func loadMemos6() {
        if let data = UserDefaults.standard.data(forKey: "memos6") {
            do {
                memos6 = try JSONDecoder().decode([Memo6].self, from: data)
            } catch {
                print("메모 불러오기 실패: \(error.localizedDescription)")
            }
        }
    }

    // 메모 삭제 함수
    func deleteMemo6(_ memo: Memo6) {
        memos6.removeAll { $0.id == memo.id }
    }
}


struct Input6: View {
    @State var todos: [String] = []
    
    @State private var newMemo6 = ""
    @ObservedObject private var memoStore6 = MemoStore6()

    
    var body: some View {
        
        VStack {
                    TextField("새로운 옷을 입력하세요", text: $newMemo6)
                        .padding()
                        .textFieldStyle(RoundedBorderTextFieldStyle())

                    Button(action: {
                        saveMemo6()
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
                    requestData6()
                }
                

                Section(header: Text("내가 추가한 옷")) {
                    ForEach(memoStore6.memos6) { memo in
                        HStack {
                            Text(memo.content)
                            Spacer()
                            Button(action: {
                                // 삭제 버튼 눌렀을 때
                                memoStore6.deleteMemo6(memo)
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
    
    private func saveMemo6() {
        guard !newMemo6.isEmpty else { return }
        memoStore6.memos6.append(Memo6(content: newMemo6))
        newMemo6 = ""
    }
}

#Preview {
    Input6()
}
