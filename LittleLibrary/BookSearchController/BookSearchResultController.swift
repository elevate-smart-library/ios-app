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
  
  enum Status {
    case recommand
    case search
  }
  
  let bookTable = BookTableView()
  
  let placeHolder = UIStackView()
  
  let recommandation = UIStackView()
  
  var books: [Book] = [] {
    
    didSet {
      bookTable.books = books
      placeHolder.isHidden = !books.isEmpty
      recommandation.isHidden = true
    }
    
  }
  
  var status: Status = .recommand {
    didSet {
      if status == .recommand {
        placeHolder.isHidden = true
        recommandation.isHidden = false
      }
    }
  }
  
  init() {
    super.init(nibName: nil, bundle: nil)
    bookTable.books = []
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    initialSuggestion()
    
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
      placeHolder.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: -70.0)
    ])
    
    placeHolder.isHidden = true
    
    view.addSubview(bookTable)
    bookTable.pinToSuperView()
    bookTable.backgroundColor = .clear
    bookTable.isScrollEnabled = true
    
    view.backgroundColor = UIColor.brandBlue
  }
  
  func initialSuggestion() {
    
    recommandation.alignment = .fill
    recommandation.axis = .vertical
    recommandation.distribution = .equalSpacing
    recommandation.spacing = 20.0
    
    let suggestions: [String] = [
      "Fiction",
      "Nonfiction",
      "Science Fiction",
      "Mysteries",
      "Graphic Books",
      "Romance"
    ]
    suggestions.forEach { string in
      let label = UILabel()
      label.font = UIFont.brandFont(ofSize: 20.0)
      label.textColor = .white
      label.textAlignment = .center
      label.text = string
      recommandation.addArrangedSubview(label)
    }
    
    recommandation.translatesAutoresizingMaskIntoConstraints = false
    bookTable.addSubview(recommandation)
    NSLayoutConstraint.activate([
      recommandation.topAnchor.constraint(equalTo: bookTable.topAnchor, constant: 20.0),
      recommandation.centerXAnchor.constraint(equalTo: bookTable.centerXAnchor)
    ])
    
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
