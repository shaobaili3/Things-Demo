//
//  AstronautViewModel.swift
//  homeProject
//
//  Created by SHAOBAI LI on 28.03.22.
//

import Foundation
import UIKit

final class AstronautViewModel {
    
    var astronauts = [Astronaut]()

    init(astronauts: [Astronaut]) {
        self.astronauts = astronauts
    }
}

extension AstronautViewModel {
    func getRandomAstronaut() -> Int {
        return Int.random(in: 0..<astronauts.count)
    }
    
}


