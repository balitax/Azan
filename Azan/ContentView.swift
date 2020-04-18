//
//  ContentView.swift
//  Azan
//
//  Created by Faiz Mokhtar on 18/04/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack(alignment: .leading) {
                    Spacer()
                    Text("15 minutes left until Maghrib")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    HStack{
                        Image(systemName: "mappin.circle.fill")
                        Text("Kuala Lumpur, Malaysia")
                            .fontWeight(.medium)
                    }
                    .font(.headline)
                }
                .frame(height: 200, alignment: .leading)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Subuh")
                        Spacer()
                        Text("5:50 AM")
                        Image(systemName: "bell.fill")
                    }
                    HStack {
                        Text("Zuhur")
                        Spacer()
                        Text("1:20 PM")
                        Image(systemName: "bell.slash.fill")
                    }
                    HStack {
                        Text("Asar")
                        Spacer()
                        Text("4:30 PM")
                        Image(systemName: "bell.slash.fill")
                    }
                    HStack {
                        Text("Maghrib")
                        Spacer()
                        Text("7:30 PM")
                        Image(systemName: "bell.slash.fill")
                    }
                    HStack {
                        Text("Isyak")
                        Spacer()
                        Text("8:30 PM")
                        Image(systemName: "bell.slash.fill")
                    }
                }
                .padding(.horizontal, 50.0)
                .padding(.top, 20)
            }
            .navigationBarTitle("Today")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
