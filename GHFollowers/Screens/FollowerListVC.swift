//
//  FollowerListVC.swift
//  GHFollowers
//
//  Created by Ahmed on 6/23/20.
//  Copyright © 2020 Ahmed. All rights reserved.
//

import UIKit

class FollowerListVC: UIViewController {

    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor                                   = UIColor.systemBackground
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    

    

}
