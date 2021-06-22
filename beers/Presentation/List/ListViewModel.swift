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
    
    private var pageIndex = 1
    private var isLoading: Bool = false
    private let PER_PAGE = 20
    
    init(beerServiceType: BeerServiceType) {
        beerService = beerServiceType
        fetchBeers()
    }
    
    func fetchBeers() {
        if isLoading { return }
        
        isLoading = true
        beerService.getBeers(page: pageIndex, perPage: PER_PAGE)
            .asObservable()
            .observe(on: MainScheduler.instance)
            .subscribe { [weak self] event in
                guard let self = self else { return }
                self.isLoading = false
                
                switch event {
                case .next(let beers):
                    var newBeers = self.beers.value
                    beers.forEach { beer in
                        newBeers.append(beer)
                    }
                    
                    self.pageIndex += 1
                    self.beers.accept(newBeers)
                case .error(let error):
                    print("error occurred: \(error)")
                case .completed:
                    break
                }
            }
            .disposed(by: disposeBag)
    }
    
    func onItemSelect(_ indexPath: IndexPath) {
        let beer = beers.value[indexPath.row]
        showDetailEvent.accept(beer)
    }
    
}
