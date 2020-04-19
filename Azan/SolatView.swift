//
//  SolatView.swift
//  Azan
//
//  Created by Faiz Mokhtar on 19/04/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import SwiftUI

struct SolatView: View {

    let title: String
    let time: String

    init(title: String, time: String) {
        self.title = title
        self.time = time
    }

    var body: some View {
        HStack {
            Text(title.uppercased())
                .fontWeight(.semibold)
            Spacer()
            Text(time)
                .fontWeight(.semibold)
        }
        .padding()
    }
}

struct SolatView_Previews: PreviewProvider {
    static var previews: some View {
        SolatView(title: "Zuhur", time: "8:50 AM")
            .previewLayout(.sizeThatFits)
    }
}
