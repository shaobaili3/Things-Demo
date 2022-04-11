//
//  AstronautsViewModel.swift
//  homeProject
//
//  Created by SHAOBAI LI on 28.03.22.
//

import Foundation
import UIKit


struct AstronautModel{
    var astronaut: Astronaut
    var isChoosen: Bool
    var option: String
}

final class AstronautListViewModel {
    var astronautsObserver: Observer<[AstronautModel]> = Observer(value: [])
    var choosenAstronauts = [Astronaut]()
}

extension AstronautListViewModel {

    var isNext: Bool {
        return choosenAstronauts.count >= 3 ? false : true
    }
    
    final func loadList(completion: @escaping () -> Void) {
        NetworkService.shared.load(resource: AstronautList.allAstronauts) { [weak self] result in
            switch result {
            case .success(let all):
                all.results.forEach({ astronaut in
                    self?.astronautsObserver.value.append(AstronautModel(astronaut: astronaut, isChoosen: false, option: ""))
                })
                completion()
            case .failure(let error):
                print(error)
                completion()
            }
        }
    }

    final func updateChoosenAstronauts() {
        choosenAstronauts = []
        astronautsObserver.value.forEach { astronautModel in
            if astronautModel.isChoosen {
                choosenAstronauts.append(astronautModel.astronaut)
            }
        }
        
    }


}
