//
//  DetailViewController.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/11.
//

import UIKit
import RxSwift
import RxCocoa
import SDWebImage

class DetailViewController: UIViewController {
    
    @IBOutlet weak var beerImage: UIImageView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionText: UITextView!
    
    let disposeBag: DisposeBag = DisposeBag()
    
    var viewModel: DetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupObserve()
    }
    
    private func setupObserve() {
        viewModel.beer
            .map { $0.firstBrewed }
            .map { "First Brewed: \($0)" }
            .bind(to: dateLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.beer
            .map { $0.name }
            .bind(to: titleLabel.rx.text)
            .disposed(by: disposeBag)
        viewModel.beer
            .map { $0.description }
            .bind(to: descriptionText.rx.text)
            .disposed(by: disposeBag)
        viewModel.beer
            .map { $0.imageUrl }
            .asDriver(onErrorDriveWith: Driver.empty())
            .drive { [weak self] imageUrl in
                if let url = URL(string: imageUrl) {
                    self?.beerImage.sd_setImage(with: url, completed: nil)
                }
            }.disposed(by: disposeBag)
    }
    
    @IBAction func back(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
}
