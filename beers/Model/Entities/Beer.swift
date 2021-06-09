//
//  Beer.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/09.
//

import Foundation

struct Beer: Decodable {
    let abv: Double
    let attenuationLevel: Double
    let brewersTips: String
    let contributedBy: String
    let description: String
    let ebc: Double?
    let firstBrewed: String
    let foodPairing: [String]
    let ibu: Double
    let id: Int
    let imageUrl: String
    let name: String
    let ph: Double?
    let srm: Double?
    let tagline: String
    let targetFg: Double
    let targetOg: Double
    
    enum CodingKeys: String, CodingKey {
        case abv
        case attenuationLevel = "attenuation_level"
        case brewersTips = "brewers_tips"
        case contributedBy = "contributed_by"
        case description
        case ebc
        case firstBrewed = "first_brewed"
        case foodPairing = "food_pairing"
        case ibu
        case id
        case imageUrl = "image_url"
        case name
        case ph
        case srm
        case tagline
        case targetFg = "target_fg"
        case targetOg = "target_og"
    }
    
}

