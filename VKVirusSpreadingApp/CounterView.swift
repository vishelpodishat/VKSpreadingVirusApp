//
//  CounterView.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 27.03.2024.
//

import UIKit

final class CounterView: UIView {

    // MARK: - UI
    let counterLabel = PrimaryLabel(with: .infectionCount)

    // MARK: - LifeCycle
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
extension CounterView {
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(counterLabel)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            counterLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            counterLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ])
    }
}
