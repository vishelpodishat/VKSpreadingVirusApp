//
//  HumanModel.swift
//  VKVirusSpreadingApp
//
//  Created by Alisher Saideshov on 27.03.2024.
//

import Foundation

struct HumanModel {
   var count: Int = 0
   private var isInfected: Bool = false

    init(count: Int = 0, isInfected: Bool = false) {
        self.count = count
        self.isInfected = isInfected
    }

    mutating func tryInfect() -> Bool {
        if !isInfected {
            isInfected = true
            return true
        }
        return false
    }

    func checkInfection() -> Bool {
        return isInfected
    }
}
