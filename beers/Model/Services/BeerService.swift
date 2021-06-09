//
//  BeerService.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/09.
//

import Foundation
import Alamofire

struct BeerService {
    
    // MARK: - Singleton
    static let shared = BeerService()
    
    // MARK: - URL
    private let baseUrl = "https://api.punkapi.com"
    
    // MARK: - Services
    func requestSomething(completion: @escaping ([Beer]?, Error?) -> ()) {
        print("passed!")
        let url = "\(baseUrl)/v2/beers?page=1&per_page=20"
        AF.request(url)
            .validate()
            .responseDecodable(of: [Beer].self) { response in
                print("passed #2 \(response)")
                guard let beers = response.value else {
                    completion(nil, response.error)
                    return
                }
                
                completion(beers, nil)
            }
    }
    
}
