//
//  Font.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

private let fontMapping: [UIFont.Weight: String] = [
  .regular: "Aileron-Regular",
  .bold: "Aileron-Bold",
  .black: "Aileron-Black",
  .heavy: "Aileron-Heavy",
  .thin: "Aileron-Thin"
]

extension UIFont {
  
  /// Get the branded font with a given size and weight
  public class func brandFont(ofSize size: CGFloat, weight: Weight = .regular) -> UIFont {
    guard let fontName = fontMapping[weight], let font = UIFont(name: fontName, size: size) else {
      fatalError("Unsupported font weight provided")
    }
    return font
  }
  
}
