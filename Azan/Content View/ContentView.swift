//
//  ContentView.swift
//  Azan
//
//  Created by Faiz Mokhtar on 18/04/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct ContentView: View {

    @ObservedObject private var viewModel: ContentViewModel

    init(viewModel: ContentViewModel = ContentViewModel()) {
        self.viewModel = viewModel
    }

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
                        Text(viewModel.locality)
                            
                            .fontWeight(.medium)
                    }
                    .font(.headline)
                }
                .frame(height: 200, alignment: .leading)
                VStack(alignment: .leading) {
                    HStack {
                        Text("Subuh")
                        Spacer()
                        Text(viewModel.fajr)
                        Image(systemName: "bell.fill")
                    }
                    HStack {
                        Text("Zuhur")
                        Spacer()
                        Text(viewModel.dhuhr)
                        Image(systemName: "bell.slash.fill")
                    }
                    HStack {
                        Text("Asar")
                        Spacer()
                        Text(viewModel.asr)
                        Image(systemName: "bell.slash.fill")
                    }
                    HStack {
                        Text("Maghrib")
                        Spacer()
                        Text(viewModel.maghrib)
                        Image(systemName: "bell.slash.fill")
                    }
                    HStack {
                        Text("Isyak")
                        Spacer()
                        Text(viewModel.isha)
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
