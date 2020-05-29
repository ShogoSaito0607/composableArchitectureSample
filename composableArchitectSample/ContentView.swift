//
//  ContentView.swift
//  composableArchitectSample
//
//  Created by ShogoSaito on 2020/05/29.
//  Copyright © 2020 bitkey. All rights reserved.
//

import SwiftUI
import ComposableArchitecture

struct ContentView: View {
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: TodosViewPart1(store: Store(
                    initialState: AppState(todos: [Todo(id: UUID(), description: "Sample", isComplete: false)]), reducer: appReducer.debug(), environment: AppEnvironment(uuid: UUID.init)))) {
                    Text("TodosView1")
                }
                NavigationLink(destination: TodosViewPart2(store: Store(
                    initialState: AppState(todos: [Todo(id: UUID(), description: "Sample", isComplete: false)]), reducer: appReducer.debug(), environment: AppEnvironment(uuid: UUID.init)))) {
                    Text("TodosView2")
                }
                NavigationLink(destination: TodosViewPart3(store: Store(
                    initialState: AppState(todos: [Todo(id: UUID(), description: "Sample", isComplete: false)]), reducer: appReducer.debug(), environment: AppEnvironment(uuid: UUID.init)))) {
                    Text("TodosView3")
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
