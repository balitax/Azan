import Foundation
import Combine
import CoreLocation

class ParentViewModel: ObservableObject {

    // MARK: - Publishers

    @Published private(set) var isLocationEnabled = false

    // MARK: - Properties

    private let locationManagerPublisher: CLLocationManagerPublisher
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Inits

    init(locationManager: CLLocationManager = CLLocationManager()) {
        self.locationManagerPublisher = CLLocationManagerPublisher(locationManager: locationManager)
        self.locationManagerPublisher.status
        .print("location status")
        .sink(receiveCompletion: { _ in
            print("new location received")
        }, receiveValue: { status in
            switch status {
            case .authorizedAlways,
                 .authorizedWhenInUse:
                self.isLocationEnabled = true
            case .denied,
                 .notDetermined,
                 .restricted:
                self.isLocationEnabled = false
            @unknown default:
                fatalError("new location authorization status is not being handled")
            }
        }).store(in: &cancellables)
    }

    func requestUserPermission() {
        self.locationManagerPublisher.requestUserPermission()
    }
}
