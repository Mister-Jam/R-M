//
//  UIViewController+Extensions.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import UIKit

public extension UIViewController {
    
    func addChild(controller: UIViewController) {
        self.addChild(controller)
        controller.view.frame = self.view.frame
        self.view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    func removeChild(childController: UIViewController) {
        childController.willMove(toParent: nil)
        childController.view.removeFromSuperview()
        childController.removeFromParent()
    }
    
    func addSubview(_ subview: UIView) {
        view.addSubview(subview)
    }
    
    func setupNavigationBar(
        backgroundColor: UIColor? = nil,
        barTintColor: UIColor,
        tintColor: UIColor) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = backgroundColor ?? .clear
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .headline),
                NSAttributedString.Key.foregroundColor: UIColor.labelDefault
            ]
            navigationBarAppearance.largeTitleTextAttributes = [NSAttributedString.Key.font: UIFont.preferredFont(forTextStyle: .extraLargeTitle), NSAttributedString.Key.foregroundColor : tintColor]
            navigationController?.navigationBar.prefersLargeTitles = true
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            navigationController?.navigationBar.barTintColor = barTintColor
            navigationController?.navigationBar.tintColor = tintColor
        }
    
    func showErrorPopup(message: String) {
        let alert = showAlert("An Error Occured", message: message)
        present(alert, animated: true)
    }
    
    func showAlert(_ title: String, message: String) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        return alert
    }
    
}

public extension UILabel {
    convenience init(
        font: UIFont,
        string: String? = nil,
        color: UIColor?,
        alignment: NSTextAlignment? = .left
    ) {
        self.init()
        if let string = string {
            text = string
        }
        if let color = color {
            textColor = color
        }
        if let alignment = alignment {
            textAlignment = alignment
        }
        self.font = font
        adjustsFontForContentSizeCategory = true
        numberOfLines = .zero
        minimumContentSizeCategory = .small
        maximumContentSizeCategory = .accessibilityLarge
    }
    
    func scalable(_ font_: UIFont) {
        font = font_
        adjustsFontForContentSizeCategory = true
        numberOfLines = 0
        if #available(iOS 15.0, *) {
            minimumContentSizeCategory = .small
            maximumContentSizeCategory = .accessibilityMedium
        }
    }
}

