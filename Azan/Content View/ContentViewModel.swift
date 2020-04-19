//
//  ContentViewModel.swift
//  Azan
//
//  Created by Faiz Mokhtar on 18/04/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class ContentViewModel: ObservableObject {

    private let locationWorker: LocationWorker

    @Published private(set) var placemark: CLPlacemark? {
        didSet {
            self.locality = placemark?.locality ?? ""
        }
    }

    @Published private(set) var locality: String = ""

    var subscriptions = Set<AnyCancellable>()


    init() {
        self.locationWorker = LocationWorker()
        locationWorker.subject.sink(receiveCompletion: { completion in
            switch completion {
            case .finished:
                print("location received")
            case .failure(let error):
                print(error.localizedDescription)
            }
        }, receiveValue: { locations in
            for location in locations {
                self.geocode(location: location)
            }
        }).store(in: &subscriptions)
    }

    private func geocode(location: CLLocation) {
        let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { placemarks, error in
            guard let placemarks = placemarks else { return }
            self.placemark = placemarks.first
        }
    }
}
