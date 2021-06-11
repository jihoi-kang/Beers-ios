//
//  DetailViewModel.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/11.
//

import Foundation
import RxSwift

class DetailViewModel {
    
    let beer: Observable<Beer>
    
    init(beer: Beer) {
        self.beer = Observable.just(beer)
    }
    
}
