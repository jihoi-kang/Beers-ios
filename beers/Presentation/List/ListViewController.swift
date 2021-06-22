//
//  ViewController.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/09.
//

import UIKit
import RxSwift
import RxCocoa
import RxSwiftExt

class ListViewController: UIViewController {
    
    // MARK: - View
    @IBOutlet weak var tableView: UITableView!
    
    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: ListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUi()
        setupObserve()
    }
    
    private func setupUi() {
        tableView.rx
            .itemSelected
            .asDriver()
            .drive(onNext: { [weak self] indexPath in
                self?.viewModel.onItemSelect(indexPath)
            }).disposed(by: disposeBag)
        tableView.rx
            .reachedBottom()
            .subscribe(onNext: { [weak self] _ in
                self?.viewModel.fetchBeers()
            }).disposed(by: disposeBag)
    }
    
    private func setupObserve() {
        viewModel.beers
            .bind(to: tableView.rx.items(cellIdentifier: "ListTableViewCell", cellType: ListTableViewCell.self)) { _, beer, cell in
                cell.bind(beer: beer)
            }.disposed(by: disposeBag)
        viewModel.showDetailEvent
            .observe(on: MainScheduler.instance)
            .subscribe(onNext: { [weak self] beer in
                self?.showDetail(beer)
            }).disposed(by: disposeBag)
    }
    
    private func showDetail(_ beer: Beer) {
        let vc = DiContainer.instance.container.resolve(DetailViewController.self, argument: beer)!
        present(vc, animated: true, completion: nil)
    }
    
}
