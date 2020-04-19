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
    private var solatWorker: SolatWorker?
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    @Published private(set) var placemark: CLPlacemark? {
        didSet {
            self.locality = placemark?.locality ?? ""
        }
    }

    @Published private(set) var locality: String = ""
    @Published private(set) var fajr: String = ""
    @Published private(set) var dhuhr: String = ""
    @Published private(set) var asr: String = ""
    @Published private(set) var maghrib: String = ""
    @Published private(set) var isha: String = ""

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
                let latitude = location.coordinate.latitude
                let longitude = location.coordinate.longitude
                self.solatWorker = SolatWorker(latitude: latitude, longitude: longitude, date: Date())
                self.fajr = self.convert(date: self.solatWorker?.fajrTime)
                self.dhuhr = self.convert(date: self.solatWorker?.zuhrTime)
                self.asr = self.convert(date: self.solatWorker?.asrTime)
                self.maghrib = self.convert(date: self.solatWorker?.maghribTime)
                self.isha = self.convert(date: self.solatWorker?.ishaTime)
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

    private func convert(date: Date?) -> String {
        guard let date = date else { return "" }
        return timeFormatter.string(from: date)
    }
}
