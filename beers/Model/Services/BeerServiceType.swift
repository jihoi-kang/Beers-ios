//
//  BeerServiceType.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/10.
//

import Foundation
import RxSwift

protocol BeerServiceType {
    func getBeers(page: Int, perPage: Int) -> Single<[Beer]>
}
