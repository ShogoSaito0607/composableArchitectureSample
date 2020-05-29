
import SwiftUI
import ComposableArchitecture

struct TodosViewPart2: View {
    let store: Store<AppState, AppAction>

        var body: some View {
            WithViewStore(self.store) { viewStore in
                List {
                    // enumeratedをつけるとclosureで擬似index(=ただの0始まりのCounter)を返せる
                    // identifiableに準拠してないデータをForEachに流す場合にはidを定義しないといけない
                    ForEach(Array(viewStore.todos.enumerated()), id: \.element.id) { (index, todo: Todo) in
                        HStack {
                            Button(action: { viewStore.send(.todo(index: index, action: .checkboxTapped))}) {
                                Image(systemName: todo.isComplete ? "checkmark.square" : "square")
                            }.buttonStyle(PlainButtonStyle())
                            TextField("Untitled todo",
                                      text: viewStore.binding(
                                        get: { $0.todos[index].description},
                                        send: { .todo(index: index, action: .textFieldChanged($0))}))
                        }.foregroundColor(todo.isComplete ? .gray : nil)
                    }
                }.navigationBarTitle("Todos")
            }
        }
}

struct TodosViewPart2_Previews: PreviewProvider {
    static var previews: some View {
        TodosViewPart2(
            store: Store(
                initialState: AppState(
                    todos: [
                        Todo(id: UUID(), description: "Todo1", isComplete: false),
                        Todo(id: UUID(), description: "TodoSecond", isComplete: false),
                        Todo(id: UUID(), description: "TodoDrei", isComplete: true)
                    ]
            ),
            reducer: appReducer,
            environment: AppEnvironment(uuid: UUID.init)
            )
        )
    }
}
