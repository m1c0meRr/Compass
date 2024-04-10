//
//  CompassBuilder.swift
//  Compass
//
//  Created by Sergey Savinkov on 09.04.2024.
//

import UIKit

final class CompassBuilder {
    static func createCompassModule() -> UIViewController {
        let view = CompassViewController()
        let compassService = CompassService()
        let presenter = CompassPresenter(view: view,
                                         compassService: compassService)
        view.presenter = presenter
        return view
    }
}
