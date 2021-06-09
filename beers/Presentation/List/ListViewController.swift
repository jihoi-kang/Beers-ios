//
//  ViewController.swift
//  beers
//
//  Created by Jihoi Kang on 2021/06/09.
//

import UIKit

class ListViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        BeerService.shared.requestSomething(completion: { result, error in
            print("error: \(error)")
            print("result: \(result)")
        })
    }


}

