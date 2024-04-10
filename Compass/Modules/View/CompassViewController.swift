//
//  ViewController.swift
//  Compass
//
//  Created by Sergey Savinkov on 09.04.2024.
//

import UIKit

final class CompassViewController: UIViewController {
    
    // MARK: - Dependency
    var presenter: CompassPresenterProtocol?

    // MARK: - UI Elements

    private let compassView: UIImageView = {
        let compass = UIImageView()
        compass.image = UIImage(named: "compass")
        compass.translatesAutoresizingMaskIntoConstraints = false
        return compass
    }()
    
    private let azimuthLabel:  UILabel = {
        let label = UILabel()
        label.text = "0° N"
        label.font = UIFont.systemFont(ofSize: 80)
        label.textColor = .white
        label.textAlignment = .center
        label.adjustsFontSizeToFitWidth = true
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.getRotationAngle()
        presenter?.getAzimuth()
        setupUI()
        setupConstraints()
    }
    
    // MARK: - Private Methods
    
    private func setupUI() {
        view.backgroundColor = .black

        view.addSubviews(compassView,
                         azimuthLabel)
    }
}

// MARK: - CompassViewControllerProtocol

extension CompassViewController: CompassViewControllerProtocol {
    
    func rotateCompass(rotationAngle: CGAffineTransform) {
        UIView.animate(withDuration: 0.25) {
            self.compassView.transform = rotationAngle
        }
    }
    
    func showAzimuth(azimuth: Double) {
        func azimuthToString(_ azimuth: Double) -> String {
            switch azimuth {
                case 0..<22.5, 337.5...360:
                    return "\(String(Int(azimuth)))° N"
                case 22.5..<67.5:
                    return "\(String(Int(azimuth)))° NE"
                case 67.5..<112.5:
                    return "\(String(Int(azimuth)))° E"
                case 112.5..<157.5:
                    return "\(String(Int(azimuth)))° SE"
                case 157.5..<202.5:
                    return "\(String(Int(azimuth)))° S"
                case 202.5..<247.5:
                    return "\(String(Int(azimuth)))° SW"
                case 247.5..<292.5:
                    return "\(String(Int(azimuth)))° W"
                case 292.5..<337.5:
                    return "\(String(Int(azimuth)))° NW"
                default:
                    return ""
            }
        }
        azimuthLabel.text = azimuthToString(azimuth)
    }
}

// MARK: - Constraints

extension CompassViewController {
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            compassView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            compassView.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -50),
            compassView.widthAnchor.constraint(equalToConstant: 320),
            compassView.heightAnchor.constraint(equalToConstant: 328),
            
            azimuthLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            azimuthLabel.topAnchor.constraint(equalTo: compassView.bottomAnchor, constant: 50)
        ])
    }
}
