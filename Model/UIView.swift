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
  
  func addShadow(color: UIColor = .black, opacity: Float = 1.0, offSet: CGSize = CGSize(width: 1.0, height: 1.0), radius: CGFloat = 10.0) {
    layer.shadowColor = color.cgColor
    layer.shadowOpacity = opacity
    layer.shadowOffset = offSet
    layer.shadowRadius = radius
  }
  
}
