/// from https://gist.github.com/zarghol/a44353833b508abb7b9046151fdf086b

import Foundation
import Combine
import CoreLocation

extension Subscriber {
    func eraseToAnySubscriber() -> AnySubscriber<Self.Input, Self.Failure> {
        return AnySubscriber<Input, Failure>.init(receiveSubscription: { sub in
            self.receive(subscription: sub)
        }, receiveValue: { value in
            self.receive(value)
        }, receiveCompletion: { completion in
            self.receive(completion: completion)
        })
    }
}

final class CLLocationManagerPublisher: NSObject, CLLocationManagerDelegate, Publisher {
    typealias Output = Data
    typealias Failure = Error

    private var manager: CLLocationManager?

    private var subscriptions: [CLLocationManagerSubscription]

    init(locationManager: CLLocationManager) {
        self.manager = locationManager
        self.subscriptions = []

        super.init()

        locationManager.delegate = self
    }

    func receive<S>(subscriber: S) where S : Subscriber, CLLocationManagerPublisher.Failure == S.Failure, CLLocationManagerPublisher.Output == S.Input {
        let subscription = CLLocationManagerSubscription(publisher: self, subscriber: subscriber)
        self.subscriptions.append(subscription)
        subscriber.receive(subscription: subscription)
    }

    private func remove(subscription: CLLocationManagerSubscription) {
        self.subscriptions.removeAll(where: { $0 === subscription })
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        self.subscriptions.forEach {
            $0.handleValue(.authorizationChange(status))
        }
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.subscriptions.forEach {
            $0.handleValue(.locations(locations))
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        self.subscriptions.forEach {
            $0.handleValue(.error(error))
        }
    }

    var errors: AnyPublisher<Error, Never> {
        return self.compactMap({ data in
            switch data {
            case .error(let error):
                return error
            default:
                return nil
            }
        })
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    var locations: AnyPublisher<[CLLocation], Never> {
        return self.compactMap({ data in
            switch data {
            case .locations(let locations):
                return locations
            default:
                return nil
            }
        })
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    var status: AnyPublisher<CLAuthorizationStatus, Never> {
        return self.compactMap({ data in
            switch data {
            case .authorizationChange(let status):
                return status
            default:
                return nil
            }
        })
            .assertNoFailure()
            .eraseToAnyPublisher()
    }

    func requestUserPermission() {
        self.manager?.requestWhenInUseAuthorization()
    }
}

extension CLLocationManagerPublisher {
    final class CLLocationManagerSubscription: Subscription {
        let subscriber: AnySubscriber<Data, Error>
        weak var publisher: CLLocationManagerPublisher?

        var currentDemand: Subscribers.Demand = .unlimited

        init<S: Subscriber>(publisher: CLLocationManagerPublisher, subscriber: S) where S.Failure == Error, S.Input == Data {
            self.subscriber = subscriber.eraseToAnySubscriber()
            self.publisher = publisher
        }

        func request(_ demand: Subscribers.Demand) {
            currentDemand = demand
        }

        func handleValue(_ value: Data) {
            let additionalDemand = subscriber.receive(value)
            currentDemand += additionalDemand

            if currentDemand <= 0 {
                subscriber.receive(completion: .finished)
                publisher?.remove(subscription: self)
            }
        }

        func cancel() {
            publisher?.remove(subscription: self)
        }
    }
}

extension CLLocationManagerPublisher {
    enum Data {
        case locations([CLLocation])
        case authorizationChange(CLAuthorizationStatus)
        case error(Error)
    }
}
