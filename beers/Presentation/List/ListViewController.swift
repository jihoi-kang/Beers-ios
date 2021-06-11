//
//  ViewController.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/09.
//

import UIKit
import RxSwift
import RxCocoa

class ListViewController: UIViewController {

    // MARK: - View
    @IBOutlet weak var tableView: UITableView!

    let disposeBag: DisposeBag = DisposeBag()
    var viewModel: ListViewModel!
    
    var beers: [Beer] = [Beer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.start()
        
        setupUi()
        setupObserve()
    }
    
    private func setupUi() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rx
            .itemSelected
            .asDriver()
            .drive(onNext: { [weak self] indexPath in
                self?.viewModel.onItemSelect(indexPath)
            }).disposed(by: disposeBag)
    }
    
    private func setupObserve() {
        viewModel.beers
            .asDriver()
            .drive(onNext: { [weak self] beers in
                self?.beers = beers
                self?.tableView.reloadData()
            }).disposed(by: disposeBag)
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

extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ListTableViewCell {
            cell.bind(beer: beers[indexPath.row])
            return cell
        }
        
        return ListTableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
}
