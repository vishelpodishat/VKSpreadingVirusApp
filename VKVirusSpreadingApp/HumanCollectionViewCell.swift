//
//  HumanCollectionViewCell.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 27.03.2024.
//

import UIKit

final class HumanCollectionViewCell: UICollectionViewCell {

    // MARK: - UI
    private let personPhotoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person")
        imageView.tintColor = AppColors.grey
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
extension HumanCollectionViewCell {
    // MARK: - Setup Views
    private func setupViews() {
        backgroundColor = .clear
        contentView.addSubview(personPhotoImageView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            personPhotoImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            personPhotoImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            personPhotoImageView.topAnchor.constraint(equalTo: topAnchor),
            personPhotoImageView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


// MARK: - Configure
extension HumanCollectionViewCell {
    // MARK: - Public methods
    func setupItem(isInfected: Bool) {
        setupViews()
        setupConstraints()
        reloadItem(isInfected: isInfected)
    }

    private func reloadItem(isInfected: Bool) {
        personPhotoImageView.tintColor = isInfected ? AppColors.red : AppColors.grey
    }
}
