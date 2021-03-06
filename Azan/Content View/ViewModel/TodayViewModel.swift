import Foundation
import Combine
import CoreLocation

class TodayViewModel: ObservableObject {

    private let locationWorker: LocationWorker
    private var solatWorker: SolatWorker?
    
    private let timeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        return formatter
    }()

    private let currentTimeFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm:ss a"
        return formatter
    }()

    @Published private(set) var placemark: CLPlacemark? {
        didSet {
            self.locality = placemark?.locality ?? ""
        }
    }

    private var latitude: CLLocationDegrees?
    private var longitude: CLLocationDegrees?

    @Published private(set) var locality: String = ""
    @Published private(set) var fajr: String = ""
    @Published private(set) var dhuhr: String = ""
    @Published private(set) var asr: String = ""
    @Published private(set) var maghrib: String = ""
    @Published private(set) var isha: String = ""

    var nextPrayer: String {
        return self.solatWorker?.nextPrayer ?? ""
    }

    var relativeTimeNextPrayer: String {
        guard let countdown = self.solatWorker?.countdownForNextPrayer else { return "" }
        let dateComponentsFormatter = DateComponentsFormatter()
        return dateComponentsFormatter.difference(from: Date(), to: countdown) ?? ""
    }

    var currentTime: String {
        return currentTimeFormatter.string(from: Date())
    }

    var currentHijriDate: String {
        let calendar = Calendar(identifier: .islamic)
        let formatter = DateFormatter()
        formatter.dateStyle  = .long
        formatter.timeStyle = .none
        formatter.calendar = calendar

        return formatter.string(from: currentDate)
    }

    var subscriptions = Set<AnyCancellable>()

    private let currentDate: Date
    private let calculationMethod: SolatCalculationMethod
    private let madhab: SolatMadhab

    // MARK: - Inits

    init(currentDate: Date = Date(),
         calculationMethod: SolatCalculationMethod,
         madhab: SolatMadhab) {
        self.calculationMethod = calculationMethod
        self.madhab = madhab
        self.currentDate = currentDate
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
                self.latitude = location.coordinate.latitude
                self.longitude = location.coordinate.longitude
                self.updatePrayerTimes(latitude: self.latitude, longitude: self.longitude)
            }
        }).store(in: &subscriptions)
    }

    func refreshPrayerTimes() {
        updatePrayerTimes(latitude: self.latitude, longitude: self.longitude)
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

    private func updatePrayerTimes(latitude: CLLocationDegrees?, longitude: CLLocationDegrees?) {
        guard let latitude = latitude,
            let longitude = longitude else {
            return
        }

        self.solatWorker = SolatWorker(
            calculationMethod: self.calculationMethod,
           madhab: self.madhab,
           latitude: latitude, longitude: longitude, date: Date())
        self.fajr = self.convert(date: self.solatWorker?.fajrTime)
        self.dhuhr = self.convert(date: self.solatWorker?.zuhrTime)
        self.asr = self.convert(date: self.solatWorker?.asrTime)
        self.maghrib = self.convert(date: self.solatWorker?.maghribTime)
        self.isha = self.convert(date: self.solatWorker?.ishaTime)
    }
}

extension DateComponentsFormatter {
    func difference(from fromDate: Date, to toDate: Date) -> String? {
        self.allowedUnits = [.hour, .minute, .second]
        self.maximumUnitCount = 1
        self.unitsStyle = .full
        return self.string(from: fromDate, to: toDate)
    }
}
