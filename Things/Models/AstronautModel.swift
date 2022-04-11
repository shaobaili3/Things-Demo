//
//  AstronautModel.swift
//  homeProject
//
//  Created by SHAOBAI LI on 28.03.22.
//

import Foundation
import UIKit

struct AstronautList: Codable {
    let results: [Astronaut]
}

struct Astronaut: Codable {
    let id: Int
    let url: String
    let name: String
    let dateOfBirth: String?
    let nationality, bio: String
    let twitter, instagram: String?
    let wiki: String
    let profileImage: URL?
    let profileImageThumbnail: URL?
}

extension AstronautList {
    
    static var allAstronauts: Resource<AstronautList> = {
        
        guard let url = URL(string: "http://spacelaunchnow.me/api/3.5.0/astronaut/") else {
            fatalError("URL is incorrect!")
        }
        
        return Resource<AstronautList>(url: url)
    }()
}

extension Astronaut {
    static func getAstronaut(id: Int) -> Resource<Astronaut> {
        guard let url = URL(string: "http://spacelaunchnow.me/api/3.5.0/astronaut/" + String(id)) else {
            fatalError("URL is incorrect!")
        }
        
        return Resource<Astronaut>(url: url)
    }
}
