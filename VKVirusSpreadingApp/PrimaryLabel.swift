//
//  PrimaryLabel.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 26.03.2024.
//

import UIKit

final class PrimaryLabel: UILabel {
    
    enum LabelType {
        case primary
        case simulation
        case infectionCount
        case percentage
    }

    init(with labelType: LabelType) {
        super.init(frame: .zero)
        configure(with: labelType)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PrimaryLabel {
    func configure(with labelType: LabelType) {
        translatesAutoresizingMaskIntoConstraints = false

        switch labelType {
        case .primary:
            font = .systemFont(ofSize: 22, weight: .bold)
            textColor = AppColors.black
            numberOfLines = 0
            textAlignment = .center
        case .simulation:
            font = .systemFont(ofSize: 16, weight: .semibold)
            textColor = AppColors.white
            numberOfLines = 0
            textAlignment = .center
        case .infectionCount:
            font = .systemFont(ofSize: 14, weight: .medium)
            textColor = AppColors.white
            textAlignment = .center
        case .percentage:
            font = .systemFont(ofSize: 14, weight: .regular)
            textColor = AppColors.grey
            textAlignment = .center
        }
    }
}
