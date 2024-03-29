//
//  Mission.swift
//  Moonshot
//
//  Created by Tiago Mamouros on 31/01/2022.
//

import Foundation

struct Mission : Codable, Identifiable {
    
    
    struct CrewRole: Codable {
        let name : String
        let role : String
    }

    
    let id : Int
    let launchDate : Date?
    let crew : [CrewRole]
    let description: String
    
    var imageName : String {
        "apollo\(id)"
    }
    
    var displayName : String {
        "Apollo \(id)"
    }
    
    var formattedLaunchDate : String {
        launchDate?.formatted(date: .abbreviated, time: .omitted) ?? "N/A"
    }
}
