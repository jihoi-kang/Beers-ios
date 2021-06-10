//
//  ListViewModel.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/10.
//

import Foundation
import RxSwift
import RxRelay

class ListViewModel {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    let beerService: BeerServiceType
    
    let beers: BehaviorRelay<[Beer]> = .init(value: [])
    
    init(beerServiceType: BeerServiceType) {
        self.beerService = beerServiceType
    }
    
    func start() {
        self.beerService.getBeers(page: 1, perPage: 20).asObservable()
            .subscribe(onNext: { [weak self] beers in
                guard let strongSelf = self else {
                    return
                }
                
                strongSelf.beers.accept(beers)
            }).disposed(by: disposeBag)
    }
    
}
