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
            List {
                Section {
                    VStack(alignment: .leading) {
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
                .padding()
                }
                Section {
                    SolatView(title: "Subuh", time: viewModel.fajr)
                    SolatView(title: "Zuhur", time: viewModel.dhuhr)
                    SolatView(title: "Asar", time: viewModel.asr)
                    SolatView(title: "Maghrib", time: viewModel.maghrib)
                    SolatView(title: "Isyak", time: viewModel.isha)
                }
            }.listStyle(GroupedListStyle()).environment(\.horizontalSizeClass, .regular)
            .navigationBarTitle("Today")
                .navigationBarItems(trailing:
                    NavigationLink(destination: EmptyView()) {
                        Image(systemName: "gear")
                    }
            )
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
