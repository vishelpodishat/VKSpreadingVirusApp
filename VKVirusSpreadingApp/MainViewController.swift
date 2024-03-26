//
//  MainViewController.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 26.03.2024.
//

import UIKit

final class MainViewController: UIViewController {

    // MARK: - UI
    private let label = PrimaryLabel(with: .primary)

    private let peopleView: MainView = {
        let view = MainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let infectionPeopleView: MainView = {
        let view = MainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let timerView: MainView = {
        let view = MainView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var stackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [peopleView, infectionPeopleView, timerView])
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private lazy var simulateButton: UIButton = {
        let button = UIButton(type: .system)
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.backgroundColor = AppColors.primaryBlue
        button.setTitleColor(AppColors.white, for: .normal)
        button.setTitle("Запустить Моделирование", for: .normal)
        button.addTarget(self, action: #selector(didTapSimulateButton), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
        setupConstraints()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
}


// MARK: - Setup
private extension MainViewController {
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = AppColors.white
        label.text = "Симулятор распространения вируса"
        [label, stackView, simulateButton].forEach(view.addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            label.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            label.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            stackView.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 50),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            stackView.heightAnchor.constraint(equalToConstant: 200),

            simulateButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                    constant: 16),
            simulateButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                     constant: -16),
            simulateButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                   constant: -20),
            simulateButton.heightAnchor.constraint(equalToConstant: 44),
        ])
    }
}

// MARK: - Action
private extension MainViewController {
    @objc private func didTapSimulateButton() {
        let vc = SimulationViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
