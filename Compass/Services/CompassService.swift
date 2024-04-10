//
//  CompassService.swift
//  Compass
//
//  Created by Sergey Savinkov on 09.04.2024.
//

import Foundation
import CoreLocation
import CoreMotion

protocol CompassServiceProtocol {
    func moveCompass(completion: @escaping (CGAffineTransform) -> Void)
    func getAzimuth(completion: @escaping (Double) -> Void)
}

final class CompassService: NSObject, CompassServiceProtocol {
    
    // MARK: - Private properties
    
    private let locationManager = CLLocationManager()
    private let motionManager = CMMotionManager()
    private var compassCompletion: ((CGAffineTransform) -> Void)?
    private var azimuthCompletion: ((Double) -> Void)?
    
    
    // MARK: - Functions
    
    func moveCompass(completion: @escaping (CGAffineTransform) -> Void) {
        compassCompletion = completion
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingHeading()
    }
    
    func getAzimuth(completion: @escaping (Double) -> Void) {
        azimuthCompletion = completion
    }
}

// MARK: - CLLocationManagerDelegate

extension CompassService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        let rotationAngle = -newHeading.trueHeading * .pi / 180.0
        let compassAngle = CGAffineTransform(rotationAngle: CGFloat(rotationAngle))
        let azimuth = manager.heading?.magneticHeading.nextUp ?? 0.0
        compassCompletion?(compassAngle)
        azimuthCompletion?(azimuth)
    }
}
