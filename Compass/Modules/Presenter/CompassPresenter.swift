//
//  CompassPresenter.swift
//  Compass
//
//  Created by Sergey Savinkov on 09.04.2024.
//

import Foundation

protocol CompassViewControllerProtocol: AnyObject {
    func rotateCompass(rotationAngle: CGAffineTransform)
    func showAzimuth(azimuth: Double)
}

protocol CompassPresenterProtocol {
    func getRotationAngle()
    func getAzimuth()
}

final class CompassPresenter {
    
    // MARK: - Private properties
    
    private weak var view: CompassViewControllerProtocol?
    private let compassService: CompassServiceProtocol
    
    // MARK: - Lifecycle
    
    init(view: CompassViewControllerProtocol,
         compassService: CompassServiceProtocol) {
        self.view = view
        self.compassService = compassService
    }
}


// MARK: - CompassPresenterProtocol

extension CompassPresenter: CompassPresenterProtocol {

    func getRotationAngle() {
        compassService.moveCompass { [weak self] angle in
            guard let self else { return }
            view?.rotateCompass(rotationAngle: angle)
        }
    }
    
    func getAzimuth() {
        compassService.getAzimuth { [weak self] azimuth in
            guard let self else { return }
            view?.showAzimuth(azimuth: azimuth)
        }
    }
}
