//
//  LocationWorker.swift
//  Azan
//
//  Created by Faiz Mokhtar on 18/04/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import Combine
import CoreLocation

class LocationWorker: NSObject, ObservableObject {

    private var locationManager: CLLocationManager = CLLocationManager()

    let subject = PassthroughSubject<[CLLocation], Error>()

    override init() {
        super.init()
        self.locationManager.delegate = self
        self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
    }
}

extension LocationWorker: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        subject.send(locations)
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        subject.send(completion: .failure(error))
    }
}
