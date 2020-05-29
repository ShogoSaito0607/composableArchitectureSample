
import SwiftUI
import ComposableArchitecture

struct Todo: Equatable, Identifiable {
    let id: UUID
    var description = ""
    var isComplete = false
}

enum TodoAction {
    case checkboxTapped
    case textFieldChanged(String)
}

struct TodoEnvironment {

}

let todoReducer = Reducer<Todo, TodoAction, TodoEnvironment> {
    state, action, environment in
    switch action {
    case .checkboxTapped:
        state.isComplete.toggle()
        return .none
    case .textFieldChanged(let text):
        state.description = text
        return .none
    }
}
