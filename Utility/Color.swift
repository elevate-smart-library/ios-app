//
//  Color.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import UIKit

public extension UIColor {
  
  /// Create a color using a hex integer (e.g. 0xAABBCC)
  public convenience init(hex: Int32) {
    let red = CGFloat((hex >> 16) & 0xff)
    let green = CGFloat((hex >> 8) & 0xff)
    let blue = CGFloat((hex >> 0) & 0xff)
    self.init(red: red / 255.0, green: green / 255.0, blue: blue / 255.0, alpha: 1.0)
  }
  
  /// Create a color using a hex string (e.g. "AABBCC")
  public convenience init?(hexString: String) {
    guard let hex = Int32(hexString, radix: 16) else {
      return nil
    }
    self.init(hex: hex)
  }
  
  public var rgbComponents: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) { // swiftlint:disable:this large_tuple
    var r: CGFloat = 0.0, g: CGFloat = 0.0, b: CGFloat = 0.0, a: CGFloat = 0.0
    getRed(&r, green: &g, blue: &b, alpha: &a)
    return (r, g, b, a)
  }
  
  // MARK: -
  
  public static let brandBlue = UIColor(hex: 0x1682B0)
  
  /**
   Get transit color between two color, with progress
   
   */
  public static func transitColor(fromColor: UIColor, toColor: UIColor, progress: CGFloat) -> UIColor {
    let (fromR, fromG, fromB, fromA) = fromColor.rgbComponents
    let (toR, toG, toB, toA) = toColor.rgbComponents
    let r = fromR + (toR - fromR) * progress
    let b = fromB + (toB - fromB) * progress
    let g = fromG + (toG - fromG) * progress
    let a = fromA + (toA - fromA) * progress
    return UIColor(red: r, green: g, blue: b, alpha: a)
  }
  
}
