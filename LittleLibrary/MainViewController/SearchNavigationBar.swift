//
//  SearchNavigationBar.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

class SearchNavigationBar: UIView {
  
  @IBOutlet var subTitle: UILabel!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.brandBlue
  }
  
}
