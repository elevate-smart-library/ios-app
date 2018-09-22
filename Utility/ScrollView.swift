//
//  ScrollView.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

class TouchThrowView: UIView {
  
  var shouldReactorToHit: ((_ point: CGPoint, _ view: UIView?) -> Bool)?
  
  override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
    let view = super.hitTest(point, with: event)
    if !(shouldReactorToHit?(point, view) ?? true) {
      return nil
    }
    return view == self ? nil : view
  }

  
}
