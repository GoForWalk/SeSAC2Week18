//
//  ViewController.swift
//  SeSAC2Week18
//
//  Created by sae hun chung on 2022/11/02.
//

import UIKit

class ViewController: UIViewController {

    let api = APIService()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        api.signUp()
//        api.login()
        api.profile()
        

    }


}

