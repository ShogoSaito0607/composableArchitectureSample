import SwiftUI
import ComposableArchitecture

// 高階Reducerを用いて記述を洗練させたVersion
struct TodosViewPart1: View {
    let store: Store<AppState, AppAction>
//    @ObservedObject var viewStore

    var body: some View {
        WithViewStore(self.store) { viewStore in
            List {
                ForEachStore(
                    self.store.scope(state: \.todos, action:
                        AppAction.todo(index:action:)),
                    content: TodoView.init(store:)
                )
            }
            .navigationBarTitle("Todos")
            .navigationBarItems(trailing: Button("Add") {
                viewStore.send(.addButtonTapped)
            })
        }
    }
}

private struct TodoView: View {
    let store: Store<Todo, TodoAction>
    var body: some View {
        WithViewStore(self.store) { viewStore in
            HStack {
                Button(action: { viewStore.send(.checkboxTapped)}) {
                    Image(systemName: viewStore.isComplete ? "checkmark.square" : "square")
                }.buttonStyle(PlainButtonStyle())
                TextField("Untitled todo",
                          text: viewStore.binding(
                            get: \.description ,
                            send: TodoAction.textFieldChanged
                          )
                )
            }
            .foregroundColor(viewStore.isComplete ? .gray : nil)
        }
    }
}

struct TodosViewPart1_Previews: PreviewProvider {
    static var previews: some View {
        TodosViewPart1(
            store: Store(
                initialState: AppState(
                    todos: [
                        Todo(id: UUID(), description: "Todo1", isComplete: false),
                        Todo(id: UUID(), description: "TodoSecond", isComplete: false),
                        Todo(id: UUID(), description: "TodoDrei", isComplete: true)
                    ]
            ), reducer: appReducer, environment: AppEnvironment(uuid: UUID.init))
        )
    }
}
