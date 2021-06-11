//
//  ListViewModel.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/10.
//

import Foundation
import RxSwift
import RxRelay
import RxCocoa

class ListViewModel {
    
    let disposeBag: DisposeBag = DisposeBag()
    
    let beerService: BeerServiceType
    
    let beers: BehaviorRelay<[Beer]> = .init(value: [])
    
    let showDetailEvent: PublishRelay<Beer> = .init()
    
    init(beerServiceType: BeerServiceType) {
        self.beerService = beerServiceType
    }
    
    func start() {
        self.beerService.getBeers(page: 1, perPage: 20)
            .asObservable()
            .bind(to: beers)
            .disposed(by: disposeBag)
    }
    
    func onItemSelect(_ indexPath: IndexPath) {
        let beer = beers.value[indexPath.row]
        showDetailEvent.accept(beer)
    }
    
}
