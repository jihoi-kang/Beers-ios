//
//  DiContainer.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/11.
//

import UIKit
import Swinject

class DiContainer {
    
    static let instance: DiContainer = DiContainer()
    let container = Container()
    
    private init() {
        self.setupViewController()
        self.setupViewModel()
    }
    
}

// ViewController
extension DiContainer {
    
    private func setupViewController() {
        self.container.register(ListViewController.self) { r in
            let storyboard = UIStoryboard(name: "Main", bundle: .main)
            let vc = storyboard.instantiateInitialViewController() as! ListViewController
            vc.viewModel = r.resolve(ListViewModel.self)!
            return vc
        }
        self.container.register(DetailViewController.self) { (r: Resolver, beer: Beer) in
            let storyboard = UIStoryboard(name: "Detail", bundle: .main)
            let vc = storyboard.instantiateViewController(identifier: "detail") as! DetailViewController
            vc.viewModel = r.resolve(DetailViewModel.self, argument: beer)!
            vc.modalPresentationStyle = .overFullScreen
            return vc
        }
    }
    
}

// ViewModel
extension DiContainer {
    
    private func setupViewModel() {
        self.container.register(ListViewModel.self) { _ in
            ListViewModel(beerServiceType: BeerService())
        }
        self.container.register(DetailViewModel.self) { _, beer in
            DetailViewModel(beer: beer)
        }
    }
    
}
