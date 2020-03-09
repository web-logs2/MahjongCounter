//
//  BaseViewController.swift
//  MahjongCounter
//
//  Created by 于涵 on 2020/3/9.
//  Copyright © 2020 yuhan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        navigationItem.backBarButtonItem = UIBarButtonItem.back()
    }
}
