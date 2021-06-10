//
//  BeerService.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/09.
//

import Foundation
import Alamofire
import RxSwift

final class BeerService: BeerServiceType {
    
    // MARK: - Singleton
    static let shared = BeerService()
    
    // MARK: - URL
    private let baseUrl = "https://api.punkapi.com"
    
    // MARK: - Services
    func getBeers(page: Int, perPage: Int) -> Single<[Beer]> {
        let url = "\(baseUrl)/v2/beers?page=\(page)&per_page=\(perPage)"
        return Single<[Beer]>.create(subscribe: { observer in
            AF.request(url)
                .validate()
                .responseDecodable(of: [Beer].self, completionHandler: { response in
                    switch response.result {
                    case .success(let data):
                        observer(.success(data))
                    case .failure(let error):
                        observer(.failure(error))
                    }
                })
            
            return Disposables.create()
        })
    }
    
}
