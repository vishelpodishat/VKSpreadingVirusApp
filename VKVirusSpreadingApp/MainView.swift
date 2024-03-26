//
//  MainView.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 27.03.2024.
//

import UIKit

final class MainView: UIView {

    // MARK: - UI
    private let mainView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.primaryBlue
        view.layer.cornerRadius = 12
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let label = PrimaryLabel(with: .simulation)

    private let simulationTextField: UITextField = {
        let textField = UITextField()
        textField.textColor = AppColors.black
        textField.font = .systemFont(ofSize: 14, weight: .medium)
        textField.keyboardType = .numberPad
        textField.backgroundColor = AppColors.bubbleBlue
        textField.layer.cornerRadius = 10
        textField.textAlignment = .center
        textField.clipsToBounds = true
        textField.translatesAutoresizingMaskIntoConstraints = false 
        return textField
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
extension MainView {
    // MARK: - Setup Views
    private func setupViews() {
        label.text = "Количество людей"
        [mainView, label, simulationTextField].forEach(addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            mainView.topAnchor.constraint(equalTo: topAnchor),
            mainView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainView.trailingAnchor.constraint(equalTo: trailingAnchor),

            label.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            label.leadingAnchor.constraint(equalTo: mainView.leadingAnchor, constant: 10),
            label.widthAnchor.constraint(equalToConstant: 200),

            simulationTextField.topAnchor.constraint(equalTo: mainView.topAnchor, constant: 13),
            simulationTextField.bottomAnchor.constraint(equalTo: mainView.bottomAnchor, constant: -13),
            simulationTextField.leadingAnchor.constraint(equalTo: label.trailingAnchor, constant: 10),
            simulationTextField.centerYAnchor.constraint(equalTo: mainView.centerYAnchor),
            simulationTextField.trailingAnchor.constraint(equalTo: mainView.trailingAnchor, constant: -10),
        ])
    }
}


// MARK: - Configure
extension MainView {
    func configure(labelText: String, textFieldText: String) {
        label.text = labelText
        simulationTextField.text = textFieldText
    }
}
