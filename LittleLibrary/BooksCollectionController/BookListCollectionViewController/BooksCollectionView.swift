//
//  BooksCollectionView.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

struct BooksViewModel {
  let name: String
  init(name: String = "aaa") {
    self.name = name
  }
}

class BooksCollectionView: UICollectionView {
  
  var books: [BooksViewModel] = [BooksViewModel(),BooksViewModel(),BooksViewModel()]
  
  static let cellIdentifier: String = "BookCell"
  
  init() {
    let layout = UICollectionViewFlowLayout()
    super.init(frame: CGRect.zero, collectionViewLayout: layout)
    layout.scrollDirection = .horizontal
    
    
    self.delegate = self
    self.dataSource = self
    
    register(BookCell.self, forCellWithReuseIdentifier: BooksCollectionView.cellIdentifier)
    
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

extension BooksCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
  
  func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    return books.count
  }
  
  func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
    
    let theCell = collectionView.dequeueReusableCell(withReuseIdentifier: BooksCollectionView.cellIdentifier, for: indexPath) as? BookCell
    if let cell = theCell {
      return cell
    }
    fatalError("cell no exist")
  }
  
}

class BookCell: UICollectionViewCell {
  
  let imageView = UIImageView()
  
  init() {
    super.init(frame: CGRect.zero)
    imageView.translatesAutoresizingMaskIntoConstraints = false
    imageView.contentMode = .scaleAspectFit
    contentView.addSubview(imageView)
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor)
    ])
    imageView.image = #imageLiteral(resourceName: "tempBook")
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
