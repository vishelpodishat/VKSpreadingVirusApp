//
//  MainViewModel.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 27.03.2024.
//

import UIKit

protocol SimulationDelegate: AnyObject {
    func reloadHumansView(for indexes: [Int])
}

final class MainViewModel {
    // MARK: - Singleton
    static let shared = MainViewModel()
    private init() {}


    // MARK: - Private properties
    private var model: SimulationModel!

    private var humans: [HumanModel] = []
    private var indexesForReload: [Int] = []
    private var indexesOfInfectedHumans: [Int] = []

    private weak var timer: Timer?
    private weak var simulationDelegate: SimulationDelegate?

    private let queue = DispatchQueue.global(qos: .userInitiated)


    // MARK: - Public methods
    func startCalculation(with model: SimulationModel, delegate: SimulationDelegate) {
        self.model = model
        self.simulationDelegate = delegate
        createTemplateHumans()
        startTimer()
    }

    func didTapHuman(at index: Int) {
        guard index <= humans.count else { return }

        if humans[index].tryInfect() {
            indexesOfInfectedHumans.append(index)
            simulationDelegate?.reloadHumansView(for: [index])
        }
    }

    func getHumansSize() -> Int {
        return humans.count
    }

    func getHumanAtIndex(_ i: Int) -> HumanModel {
        guard i < humans.count else { return HumanModel()}
        return humans[i]
    }

    func stopCalculation() {
        timer?.invalidate()
        indexesOfInfectedHumans = []
        humans = []
    }

    func getInfectedCount() -> Int {
        return indexesOfInfectedHumans.count
    }


    // MARK: - Private methods
    private func createTemplateHumans() {
        humans = [HumanModel](repeating: HumanModel(), count: model.groupSize)
    }

    private func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: model.tInterval,
                                     target: self, 
                                     selector: #selector(calculateInfection),
                                     userInfo: nil, 
                                     repeats: true)
        timer?.tolerance = model.tInterval * 0.2
    }

    @objc private func calculateInfection(){
        guard indexesOfInfectedHumans.count != humans.count else { return }

        queue.async {
            for h in self.indexesOfInfectedHumans {
                self.infectNearHumans(for: h, times: self.model.infectionFactor)
            }

            DispatchQueue.main.async {
                self.simulationDelegate?.reloadHumansView(for: self.indexesForReload.map { $0 } )
            }
        }

        self.indexesForReload = []
    }

    private func infectNearHumans(for index: Int, times: Int) {
        guard times > 0 else { return }

        let NearHumanIndexes = getNearIndexes(for: index)

        let n = NearHumanIndexes[Int.random(in: 0..<NearHumanIndexes.count)]
        if n >= 0 && n < humans.count {
            if humans[n].tryInfect() {
                indexesOfInfectedHumans.append(n)
                indexesForReload.append(n)
            }
            if Bool.random() {
                infectNearHumans(for: n, times: times - 1)
            }
        }
    }

    private func getNearIndexes(for index: Int) -> [Int] {
        var indexes = [index+7, index-7]

        if index % 7 == 0 {
            indexes.append(index+1)
        }
        else if index % 7 == 6 {
            indexes.append(index-1)
        }
        else {
            indexes.append(index-1)
            indexes.append(index+1)
        }
        return indexes
    }
}
