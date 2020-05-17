//
//  SolatWorker.swift
//  Azan
//
//  Created by Faiz Mokhtar on 19/04/2020.
//  Copyright © 2020 Faiz Mokhtar. All rights reserved.
//

import Foundation
import Adhan

class SolatWorker {

    private let prayerTimes: PrayerTimes?

    var fajrTime: Date? {
        return prayerTimes?.fajr
    }

    var zuhrTime: Date? {
        return prayerTimes?.dhuhr
    }

    var asrTime: Date? {
        return prayerTimes?.asr
    }

    var maghribTime: Date? {
        return prayerTimes?.maghrib
    }

    var ishaTime: Date? {
        return prayerTimes?.isha
    }

    var nextPrayer: String? {
        return prayerTimes?.nextPrayer()?.name
    }

    var countdownForNextPrayer: Date?

    init(latitude: Double, longitude: Double, date: Date) {
        let coordinates = Coordinates(latitude: latitude, longitude: longitude)
        let cal = Calendar(identifier: Calendar.Identifier.gregorian)
        let dateComponents = cal.dateComponents([.year, .month, .day], from: date)
        var params = Adhan.CalculationMethod.moonsightingCommittee.params
        params.madhab = .shafi
        self.prayerTimes = PrayerTimes(coordinates: coordinates, date: dateComponents, calculationParameters: params)
        guard let next = self.prayerTimes?.nextPrayer() else { return }
        self.countdownForNextPrayer = prayerTimes?.time(for: next)
    }
}

extension Prayer {
    var name: String {
        switch self {
        case .fajr:
            return "Subuh"
        case .dhuhr:
            return "Zuhur"
        case .asr:
            return "Asr"
        case .maghrib:
            return "Maghrib"
        case .isha:
            return "Isha"
        case .sunrise:
            return "Sunrise"
        }
    }
}
