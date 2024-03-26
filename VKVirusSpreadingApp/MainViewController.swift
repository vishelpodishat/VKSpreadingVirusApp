//
//  MainViewController.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 26.03.2024.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - UI
    private let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        return label
    }()

    private lazy var modelingButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.backgroundColor = AppColors.primaryBlue
        button.setTitleColor(AppColors.white, for: .normal)
        button.setTitle("Запустить Моделирование", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }
}


// MARK: - Setup
private extension MainViewController {
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        view.addSubview(modelingButton)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            modelingButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 16),
            modelingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, 
                                                     constant: -16),
            modelingButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -20),
            modelingButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}
