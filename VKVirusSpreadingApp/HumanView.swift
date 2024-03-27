//
//  HumanView.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 27.03.2024.
//

import UIKit

final class HumanView: UIView {

    // MARK: - Properties
    private let rowCount: CGFloat = 7

    // MARK: - UI
    private lazy var collectiomViewFlowLayout: UICollectionViewFlowLayout = createFlowLayout()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectiomViewFlowLayout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(ofType: HumanCollectionViewCell.self)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
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
extension HumanView {
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(collectionView)
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
}

// MARK: - Configure
extension HumanView {
    func reloadItems(at indexes: [Int]) {
        let indexPaths = indexes.map( { IndexPath(item: $0, section: 0)})
        DispatchQueue.main.async {
            self.collectionView.reconfigureItems(at: indexPaths)
        }
    }
}


// MARK: - UICollectionViewFlowLayout
extension HumanView: UICollectionViewDelegateFlowLayout {
    private func createFlowLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 3, left: 1, bottom: 3, right: 1)
        layout.minimumInteritemSpacing = 1
        layout.minimumLineSpacing = 3
        return layout
    }

    func collectionView(_ collectionView: UICollectionView, 
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width
        let numberOfItemsPerRow: CGFloat = rowCount
        let spacing: CGFloat = collectiomViewFlowLayout.minimumInteritemSpacing
        let openWidth = width - spacing * (numberOfItemsPerRow + 1)
        let itemDimension = floor(openWidth / numberOfItemsPerRow)
        return CGSize(width: itemDimension, height: 80)
    }
}

// MARK: - UICollectionView Delegate and Data Source
extension HumanView: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        MainViewModel.shared.getHumansSize()
    }
    
    func collectionView(_ collectionView: UICollectionView, 
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let item: HumanCollectionViewCell = collectionView.dequeue(cellForItemAt: indexPath)
        item.setupItem(isInfected:  MainViewModel.shared.getHumanAtIndex(indexPath.row).checkInfection())
        return item
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let feedbackGenerator = UIImpactFeedbackGenerator(style: .light)
        if  MainViewModel.shared.getHumanAtIndex(indexPath.row).checkInfection() {
            feedbackGenerator.impactOccurred()
        }
        MainViewModel.shared.didTapHuman(at: indexPath.row)
    }
}
