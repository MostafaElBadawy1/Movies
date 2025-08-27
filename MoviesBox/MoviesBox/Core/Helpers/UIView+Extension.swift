//
//  UIView+Extension.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import UIKit

extension UIView {
    func showToast(message: String, duration: Double = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textAlignment = .center
        toastLabel.alpha = 0.0
        toastLabel.numberOfLines = 0
        toastLabel.layer.cornerRadius = 12
        toastLabel.layer.masksToBounds = true
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        
        self.addSubview(toastLabel)
        
        // Constraints
        NSLayoutConstraint.activate([
            toastLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 32),
            toastLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -32),
            toastLabel.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40)
        ])
        
        UIView.animate(withDuration: 0.3, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}

