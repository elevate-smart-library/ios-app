//
//  MainViewController.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    LLService.shared.getSomething()
      // Do any additional setup after loading the view.
  }

}
