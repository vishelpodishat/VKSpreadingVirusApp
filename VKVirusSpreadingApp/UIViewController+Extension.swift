//
//  UIViewController+Extension.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 26.03.2024.
//

import UIKit

extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard(_:)))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }

    @objc func dismissKeyboard(_ sender: UITapGestureRecognizer) {
        view.endEditing(true)

        if let nav = self.navigationController {
            nav.view.endEditing(true)
        }
    }
 }
