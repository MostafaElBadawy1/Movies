//
//  MainViewController.swift
//  MoviesBox
//
//  Created by Mostafa ElBadawy on 24/08/2025.
//

import Foundation
import Combine
import UIKit

class MainViewController: UIViewController {
    var cancellables = Set<AnyCancellable>()
}
extension UIViewController {
    func showToast(message: String, duration: TimeInterval = 2.0) {
        let toastLabel = UILabel()
        toastLabel.text = message
        toastLabel.textColor = .white
        toastLabel.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        toastLabel.textAlignment = .center
        toastLabel.font = .systemFont(ofSize: 14)
        toastLabel.numberOfLines = 0
        toastLabel.alpha = 0
        toastLabel.layer.cornerRadius = 8
        toastLabel.clipsToBounds = true
        
        let maxSizeTitle = CGSize(width: self.view.bounds.size.width - 40, height: self.view.bounds.size.height)
        var expectedSizeTitle = toastLabel.sizeThatFits(maxSizeTitle)
        expectedSizeTitle.width += 20
        expectedSizeTitle.height += 20
        
        toastLabel.frame = CGRect(
            x: (self.view.frame.size.width - expectedSizeTitle.width) / 2,
            y: self.view.frame.size.height - 100,
            width: expectedSizeTitle.width,
            height: expectedSizeTitle.height
        )
        
        self.view.addSubview(toastLabel)
        
        UIView.animate(withDuration: 0.5, animations: {
            toastLabel.alpha = 1.0
        }) { _ in
            UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                toastLabel.alpha = 0.0
            }) { _ in
                toastLabel.removeFromSuperview()
            }
        }
    }
}
