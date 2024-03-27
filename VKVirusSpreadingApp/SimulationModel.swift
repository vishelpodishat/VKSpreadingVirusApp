//
//  SimulationModel.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 27.03.2024.
//

import Foundation

struct SimulationModel {
    var groupSize: Int = 0
    var infectionFactor: Int = 0
    var timer: Int = 1
    var tInterval: TimeInterval {
        get {
            return TimeInterval(timer)
        }
    }

    init(groupSize: Int, infectionFactor: Int, timer: Int) {
        self.groupSize = groupSize
        self.infectionFactor = infectionFactor
        self.timer = timer
    }
}
