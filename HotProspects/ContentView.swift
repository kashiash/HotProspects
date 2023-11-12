//
//  ContentView.swift
//  HotProspects
//
//  Created by Jacek Kosinski U on 12/11/2023.
//

import SwiftUI
import Foundation



struct ContentView: View {
    @State private var selectedTab = "One"
    @StateObject var updater = DelayedUpdater()
    @State private var output = ""

    var body: some View {
        TabView (selection: $selectedTab){
            Text("Tab 1")
            Text("Value is: \(updater.value)")
            Text(output)
                .task {
                    await fetchReadings()
                }
                .onTapGesture {
                    selectedTab = "Two"
                }
                .tabItem {
                    Label("One", systemImage: "star")
                }.tag("One")
            Text("Tab 2")
            Text("Value is: \(updater.value)")
                .onTapGesture {
                    selectedTab = "One"
                }
                .tabItem {
                    Label("Two", systemImage: "circle")
                }.tag("Two")
        }

    }

    func fetchReadings() async {
        let fetchTask = Task { () -> String in
            let url = URL(string: "https://hws.dev/readings.json")!
            let (data, _) = try await URLSession.shared.data(from: url)
            let readings = try JSONDecoder().decode([Double].self, from: data)
            return "Found \(readings.count) readings"
        }

        let result = await fetchTask.result   
        switch result {
            case .success(let str):
                output = str
            case .failure(let error):
                output = "Error: \(error.localizedDescription)"
        }
    }
}

#Preview {
    ContentView()
}

@MainActor class DelayedUpdater: ObservableObject {
  //  @Published
        var value = 0 {
        willSet {
            objectWillChange.send()
        }
    }

    init() {
        for i in 1...10 {
            DispatchQueue.main.asyncAfter(deadline: .now() + Double(i)) {
                self.value += 1
            }
        }
    }
}
