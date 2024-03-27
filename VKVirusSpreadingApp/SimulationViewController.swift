//
//  SimulationViewController.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 26.03.2024.
//

import UIKit

final class SimulationViewController: UIViewController {

    // MARK: - View Model
    var timer: Timer = Timer()
    private var simulationModel: SimulationModel!
    var currentTime: Int = 0


    // MARK: - UI
    private let infectionCountView = StatisticView(label: "Заражено")
    private let healthCountView = StatisticView(label: "Здоровы")

    private lazy var statsStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [infectionCountView, healthCountView])
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let counterView: CounterView = {
        let view = CounterView()
        view.backgroundColor = AppColors.primaryBlue
        view.layer.cornerRadius = 15
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let humansContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = AppColors.gridColor
        view.layer.cornerRadius = 20
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private lazy var collectionView: HumanView = {
        let collectionView = HumanView()
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: - Init
    convenience init(model: SimulationModel) {
        self.init()
        self.simulationModel = model
    }

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()

        MainViewModel.shared.startCalculation(with: simulationModel, delegate: self)
        setupViews()
        setupConstraints()
    }
}

// MARK: - Setup
private extension SimulationViewController {
    // MARK: - Setup Views
    private func setupViews() {
        view.backgroundColor = .white
        infectionCountView.translatesAutoresizingMaskIntoConstraints = false
        healthCountView.translatesAutoresizingMaskIntoConstraints = false

        [counterView, statsStackView, humansContainerView].forEach(view.addSubview)
        humansContainerView.addSubview(collectionView)

        infectionCountView.setupInitialValue(simulationModel.groupSize)
        healthCountView.setupInitialValue(simulationModel.groupSize)
        infectionCountView.reloadView(0)
        healthCountView.reloadView(simulationModel.groupSize)

        counterView.counterLabel.text = "\(simulationModel.timer)"

        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { _ in
            self.timerLabelReload()
        })
        timer.tolerance = 0.2
    }

    // MARK: - Setup Constraints
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            counterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 50),
            counterView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            counterView.heightAnchor.constraint(equalToConstant: 40),
            counterView.widthAnchor.constraint(equalToConstant: 40),

            statsStackView.leadingAnchor.constraint(equalTo: counterView.trailingAnchor, constant: 12),
            statsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            statsStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            statsStackView.bottomAnchor.constraint(equalTo: counterView.bottomAnchor),

            humansContainerView.topAnchor.constraint(equalTo: counterView.bottomAnchor, constant: 25),
            humansContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20),
            humansContainerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            humansContainerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

            collectionView.topAnchor.constraint(equalTo: humansContainerView.topAnchor),
            collectionView.bottomAnchor.constraint(equalTo: humansContainerView.bottomAnchor),
            collectionView.trailingAnchor.constraint(equalTo: humansContainerView.trailingAnchor, constant: -10),
            collectionView.leadingAnchor.constraint(equalTo: humansContainerView.leadingAnchor, constant: 10)
        ])
    }
}


// MARK: - Action
private extension SimulationViewController {
    @objc private func didTapBackButton() {
        MainViewModel.shared.stopCalculation()
        timer.invalidate()
        navigationController?.popViewController(animated: true)
    }

    private func timerLabelReload() {
        if currentTime <= simulationModel.timer && currentTime > 1 {
            currentTime -= 1
        }
        else {
            currentTime = simulationModel.timer
        }
        counterView.counterLabel.text = "\(currentTime)"
    }
}

// MARK: - Delegate
extension SimulationViewController: SimulationDelegate {
    func reloadHumansView(for indexes: [Int]) {
        let currentInfected =   MainViewModel.shared.getInfectedCount()
        let currentGroupSize = simulationModel.groupSize - currentInfected

        infectionCountView.reloadView(currentInfected)
        healthCountView.reloadView(currentGroupSize)

        collectionView.reloadItems(at: indexes)
    }
}
