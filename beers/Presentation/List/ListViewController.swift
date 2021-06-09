//
//  ViewController.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/09.
//

import UIKit

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var beers: [Beer] = [Beer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchBeers()
    }
    
    private func fetchBeers() {
        BeerService.shared.requestSomething(completion: { [weak self] result, error in
            guard let strongSelf = self,
                let fetchedBeers = result,
                  error == nil else {
                print("Error occured!")
                return
            }
            
            fetchedBeers.map({ beer in
                strongSelf.beers.append(beer)
            })
            
            strongSelf.tableView.reloadData()
        })
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
