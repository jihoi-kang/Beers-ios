//
//  DetailViewController.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/11.
//

import UIKit
import RxSwift
import RxCocoa

class DetailViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObserve()
    }
    
    private func setupObserve() {
        viewModel.beer
            .map({ beer in
                beer.name
            }).asDriver(onErrorDriveWith: Driver.empty())
            .drive(titleLabel.rx.text)
            .disposed(by: disposeBag)
    }

}
