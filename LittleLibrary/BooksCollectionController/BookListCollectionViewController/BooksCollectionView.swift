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
  
  final class Design {
    static let defaultHeight: CGFloat = 320.0
  }
  
  var books: [BooksViewModel] = [BooksViewModel(),BooksViewModel(),BooksViewModel()]
  
  static let cellIdentifier: String = "BookCell"
  
  init() {
    let layout = UICollectionViewFlowLayout()
    super.init(frame: CGRect.zero, collectionViewLayout: layout)
    layout.scrollDirection = .horizontal
    layout.itemSize = CGSize(width: 143.0, height: 311.0)
    layout.minimumInteritemSpacing = 17.0
    layout.minimumLineSpacing = 17.0
    backgroundColor = .clear
    self.delegate = self
    self.dataSource = self
    
    showsHorizontalScrollIndicator = false

    contentInset = UIEdgeInsets(top: 0, left: 17.0, bottom: 0, right: 17.0);

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
  let ratting = Ratting()
  
  let bookName = UILabel()
  let author = UILabel()
  
  override init(frame: CGRect) {
    super.init(frame: frame)
    
    imageView.addShadow(color: UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.16),  offSet: CGSize(width: 0.0, height: 7.0), radius: 9.0)
    
    bookName.font = UIFont.brandFont(ofSize: 14.0, weight: .bold)
    bookName.text = "Melmoth"
    
    author.font = UIFont.brandFont(ofSize: 14.0, weight: .semibold)
    author.text = "by Sarah Perry"
    
    contentView.addSubview(imageView)
    contentView.addSubview(ratting)
    contentView.addSubview(bookName)
    contentView.addSubview(author)
    
    imageView.contentMode = .scaleAspectFit
    imageView.image = #imageLiteral(resourceName: "tempBook")

    ratting.ratting = 4
    
    imageView.translatesAutoresizingMaskIntoConstraints = false
    ratting.translatesAutoresizingMaskIntoConstraints = false
    bookName.translatesAutoresizingMaskIntoConstraints = false
    author.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      imageView.topAnchor.constraint(equalTo: contentView.topAnchor),
      imageView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      imageView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      imageView.heightAnchor.constraint(equalToConstant: 220.0),
      
      ratting.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15.0),
      ratting.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 0.0),
      ratting.widthAnchor.constraint(equalToConstant: 100.0),
      ratting.heightAnchor.constraint(equalToConstant: 20.0),
      
      bookName.topAnchor.constraint(equalTo: ratting.bottomAnchor, constant: 11.0),
      bookName.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      bookName.rightAnchor.constraint(equalTo: contentView.rightAnchor),
      
      author.topAnchor.constraint(equalTo: bookName.bottomAnchor, constant: 5.0),
      author.leftAnchor.constraint(equalTo: contentView.leftAnchor),
      author.rightAnchor.constraint(equalTo: contentView.rightAnchor),

    ])
    
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}

class Ratting: UIStackView {
  
  let stars: [UIImageView] = [
    UIImageView(),
    UIImageView(),
    UIImageView(),
    UIImageView(),
    UIImageView()
  ]
  
  // Ratting 0 - 5
  var ratting: Int = 0 {
    didSet {
      for (index, image) in stars.enumerated() {
        if index < ratting {
          image.image = #imageLiteral(resourceName: "Yellow_Star")
        } else {
          image.image = #imageLiteral(resourceName: "Grey_Star")
        }
      }
    }
  }
  
  init() {
    super.init(frame: CGRect.zero)
    
    alignment = .center
    axis = .horizontal
    distribution = .equalSpacing
    
    stars.forEach { imageView in
      self.addArrangedSubview(imageView)
    }
  }
  
  
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
