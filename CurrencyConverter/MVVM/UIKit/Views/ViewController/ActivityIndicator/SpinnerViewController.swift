//
//  SpinnerViewController.swift
//  CurrencyConverter
//
//  Created by kanagasabapathy on 07/09/23.
//

import UIKit

class SpinnerViewController: UIViewController {
    var spinner = UIActivityIndicatorView(style: .large)

    override func loadView() {
        view = UIView()
        view.backgroundColor = UIColor(white: 0, alpha: 0.5)

        spinner.startAnimating()
        view.addSubview(spinner)
        spinner.setAutoLayout()
        spinner.anchorCenter(centerX: view.centerXAnchor, centerY: view.centerYAnchor)
    }
}
