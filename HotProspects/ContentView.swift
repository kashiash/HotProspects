//
//  ContentView.swift
//  HotProspects
//
//  Created by Jacek Kosinski U on 12/11/2023.
//

import SwiftUI
import Foundation

@MainActor class User: ObservableObject {
    @Published var name = "Jurek Ogurek"
}

struct EditView: View {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name", text: $user.name).border(/*@START_MENU_TOKEN@*/Color.black/*@END_MENU_TOKEN@*/)
    }
}

struct DisplayView: View {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}
struct EditView2: View  {
    @EnvironmentObject var user: User

    var body: some View {
        TextField("Name:",text: $user.name)
    }
}

struct DisplayView2: View  {
    @EnvironmentObject var user: User

    var body: some View {
        Text(user.name)
    }
}
struct ContentView: View {
    @StateObject private var user = User()
    var body: some View {
        VStack {

            EditView()
            DisplayView()
        }
        .padding()
        .environmentObject(user)
    }
}

#Preview {
    ContentView()
}
