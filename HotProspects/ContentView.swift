//
//  ContentView.swift
//  HotProspects
//
//  Created by Jacek Kosinski U on 12/11/2023.
//

import SwiftUI
import Foundation



struct ContentView: View {


    var body: some View {
        Image("alienGreen")
            .interpolation(.none)
            .resizable()
            .scaledToFit()
            .frame(maxHeight: .infinity)
            .background(.black)
            .ignoresSafeArea()

    }


}

#Preview {
    ContentView()
}

