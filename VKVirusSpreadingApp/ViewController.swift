//
//  ViewController.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 26.03.2024.
//

import UIKit

final class ViewController: UIViewController {

    // MARK: - UI
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private lazy var modelingButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 8
        button.layer.masksToBounds = true
        button.backgroundColor = .red
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Продолжить", for: .normal)
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .red
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {

    }
}

