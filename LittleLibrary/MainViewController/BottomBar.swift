//
//  BottomBar.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-23.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

class BottomBar: UIView {
  
  let browseButton = BottomBarButton(withImage: #imageLiteral(resourceName: "browse"))
  let historyButton = BottomBarButton(withImage: #imageLiteral(resourceName: "Scan"))
  let scanButton = BottomBarButton(withImage: #imageLiteral(resourceName: "history"))
  
  var buttons: [BottomBarButton] = []
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    buttons = [browseButton, scanButton, historyButton]
    
    buttons.forEach { button in
      button.translatesAutoresizingMaskIntoConstraints = false
      addSubview(button)
    }
    
    NSLayoutConstraint.activate([
      browseButton.topAnchor.constraint(equalTo: topAnchor),
      browseButton.leftAnchor.constraint(equalTo: leftAnchor),
      browseButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0 / 3.0),
      browseButton.heightAnchor.constraint(equalToConstant: 49.0),
      
      historyButton.topAnchor.constraint(equalTo: topAnchor),
      historyButton.leftAnchor.constraint(equalTo: browseButton.rightAnchor),
      historyButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0 / 3.0),
      historyButton.heightAnchor.constraint(equalToConstant: 49.0),
      
      scanButton.topAnchor.constraint(equalTo: topAnchor),
      scanButton.leftAnchor.constraint(equalTo: historyButton.rightAnchor),
      scanButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.0 / 3.0),
      scanButton.heightAnchor.constraint(equalToConstant: 49.0)
    ])
    
  }
  
}

extension BottomBar {
  
  class BottomBarButton: UIView {
    
    let imageView = UIImageView()
    
    let indicator = UIView()
    
    let button = UIButton()
    
    var didSelect: ((_ button: BottomBarButton) -> Void)?
    
    var isSelected: Bool = false {
      didSet {
        indicator.isHidden = !isSelected
      }
    }
    
    init(withImage: UIImage) {
      super.init(frame: CGRect.zero)
      
      
      imageView.translatesAutoresizingMaskIntoConstraints = false
      indicator.translatesAutoresizingMaskIntoConstraints = false
      indicator.backgroundColor = UIColor.brandIndicatorBlue
      
      imageView.image = withImage
      imageView.contentMode = .scaleAspectFit
      
      addSubview(imageView)
      addSubview(indicator)
      
      addSubview(button)
      button.pinToSuperView()
      
      indicator.isHidden = true
      
      NSLayoutConstraint.activate([
        imageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        imageView.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        indicator.bottomAnchor.constraint(equalTo: bottomAnchor),
        indicator.widthAnchor.constraint(equalToConstant: 55.0),
        indicator.heightAnchor.constraint(equalToConstant: 3.0),
        indicator.centerXAnchor.constraint(equalTo: centerXAnchor)
      ])
      
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
  }
  
}
