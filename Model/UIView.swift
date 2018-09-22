//
//  UIView.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
  
  func pinToSuperView() {
    guard let superView = superview else { fatalError("There is no superview") }
    
    self.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      self.topAnchor.constraint(equalTo: superView.topAnchor),
      self.bottomAnchor.constraint(equalTo: superView.bottomAnchor),
      self.leftAnchor.constraint(equalTo: superView.leftAnchor),
      self.rightAnchor.constraint(equalTo: superView.rightAnchor)
    ])
  }
  
}
