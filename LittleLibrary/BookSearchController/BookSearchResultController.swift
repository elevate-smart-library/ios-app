//
//  File.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-23.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

class BookSearchResultController: UIViewController {
  
  let bookTable = BookTableView()
  
  let placeHolder = UIStackView()
  
  init() {
    super.init(nibName: nil, bundle: nil)
    bookTable.books = []
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    placeHolder.alignment = .fill
    placeHolder.axis = .vertical
    placeHolder.distribution = .equalSpacing
    placeHolder.spacing = 30.0
    let imageView = UIImageView(image: #imageLiteral(resourceName: "noResult"))
    imageView.contentMode = .scaleAspectFit
    placeHolder.addArrangedSubview(imageView)
    let messageLable = UILabel()
    messageLable.textAlignment = .center
    messageLable.numberOfLines = 0
    messageLable.text = "The book you are searching for should\nbe available in 14 days."
    messageLable.font = UIFont.brandFont(ofSize: 14.0)
    messageLable.textColor = .white
    placeHolder.addArrangedSubview(messageLable)
    placeHolder.translatesAutoresizingMaskIntoConstraints = false
    
    view.addSubview(placeHolder)
    NSLayoutConstraint.activate([
      placeHolder.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      placeHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -20.0)
    ])
    
    view.addSubview(bookTable)
    bookTable.pinToSuperView()
    bookTable.backgroundColor = .clear
    bookTable.isScrollEnabled = true
    
    view.backgroundColor = UIColor.brandBlue
    
    
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
