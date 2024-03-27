//
//  StatisticView.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 27.03.2024.
//

import UIKit

final class StatisticView: UIView {

    // MARK: - Initial Value
    private var initalValue: Double = 0

    // MARK: - UI
    private let backgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.primaryBlue
        view.layer.cornerRadius = 16
        view.clipsToBounds = true
        return view
    }()

    private let headerlabel = PrimaryLabel(with: .simulation)
    private let countlabel = PrimaryLabel(with: .infectionCount)
    private let percentagelabel = PrimaryLabel(with: .percentage)
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    convenience init(label: String) {
        self.init()
        headerlabel.text = label
    }
}

// MARK: - Setup
extension StatisticView {
    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = AppColors.primaryBlue
        layer.cornerRadius = 20
        clipsToBounds = true
        [backgroundView, headerlabel, countlabel, percentagelabel].forEach(addSubview)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            backgroundView.heightAnchor.constraint(equalTo: heightAnchor),
            backgroundView.widthAnchor.constraint(equalTo: widthAnchor),

            headerlabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            headerlabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),

            countlabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            countlabel.centerYAnchor.constraint(equalTo: centerYAnchor),

            percentagelabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            percentagelabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -10)
        ])
    }
}


// MARK: - Configure
extension StatisticView {
    func reloadView(_ newValue: Int) {
        countlabel.text = "\(newValue)"
        let percentageValue = initalValue == 0 ? 0 : (Double(newValue) / initalValue) * 100
        percentagelabel.text = "\(Int(percentageValue))%"
    }

    func setupInitialValue(_ value: Int) {
        initalValue = Double(value)
    }
}
