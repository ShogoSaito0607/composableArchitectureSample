
import Foundation
import ComposableArchitecture

struct AppState: Equatable {
    var todos: [Todo]
}

enum AppAction {
    case addButtonTapped
    case todo(index: Int, action: TodoAction)
    case todoDelayCompleted
//    case todoCheckboxTapped(index: Int)
//    case todoTextFieldChanged(index: Int, text: String)
}

struct AppEnvironment {
    var uuid: () -> UUID
}

let appReducer = Reducer<AppState, AppAction, AppEnvironment>.combine(
    todoReducer.forEach(
        state: \AppState.todos,
        action: /AppAction.todo(index:action:),
        environment: { _ in TodoEnvironment() }
    ),
    Reducer { state, action, environment in
        switch action {
        case .addButtonTapped:
            state.todos.insert(Todo(id: environment.uuid()), at: 0)
            return .none
        case .todo(index: _, action: .checkboxTapped):
            struct CancelDelayId: Hashable {}

            return .concatenate(
                .cancel(id: "completion effect"),

                Effect(value: AppAction.todoDelayCompleted)
                .delay(for: 1, scheduler: DispatchQueue.main)
                .eraseToEffect()
                .cancellable(id: CancelDelayId())
            )
        case .todo(index: let index, action: let action):
            return .none
        case .todoDelayCompleted:
            state.todos = state.todos
                .enumerated()
                .sorted { lhs, rhs in
                (!lhs.element.isComplete && rhs.element.isComplete)
                    || lhs.offset < rhs.offset
            }
            .map(\.element)
            return .none
        }
    }
)
.debug()


//    let appReducer: Reducer<AppState, AppAction, AppEnvironment> = { state, action, environment in
//    switch action {
//    case .todoCheckboxTapped(index: let index):
//        state.todos[index].isComplete.toggle()
//        return .none
//    case .todoTextFieldChanged(index: let index, text: let text):
//        state.todos[index].description = text
//        return .none
//    }
//}.debug()
