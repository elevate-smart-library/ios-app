//
//  BookListViewController.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import UIKit

class BookListViewController: UIViewController {

  @IBOutlet var scrollView: UIScrollView!
  
  let justAddHeader = BookListHeader()
  let justAddBooks = BooksCollectionView()
  
  let recommandHeader = BookListHeader()
  let recommandBooks = BooksCollectionView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    justAddHeader.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: BookListHeader.Design.height)
    justAddHeader.title.text = "Just Add"
    justAddBooks.frame = CGRect(x: 0.0, y: justAddHeader.frame.maxY, width: view.frame.width, height: BooksCollectionView.Design.defaultHeight)
    
    recommandHeader.frame = CGRect(x: 0.0, y: justAddBooks.frame.maxY, width: view.frame.width, height: BookListHeader.Design.height)
    recommandHeader.title.text = "Recommanded"
    recommandBooks.frame = CGRect(x: 0.0, y: recommandHeader.frame.maxY, width: view.frame.width, height: BooksCollectionView.Design.defaultHeight)

    
    scrollView.addSubview(justAddHeader)
    scrollView.addSubview(justAddBooks)
    
    scrollView.addSubview(recommandHeader)
    scrollView.addSubview(recommandBooks)
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    var contentSize = scrollView.contentSize
    contentSize.height = recommandBooks.frame.maxY
    scrollView.contentSize = contentSize
  }

}

class BookListHeader: UIView {
  
  final class Design {
    static let height: CGFloat = 22.0 + 10.0 + 10.0
  }
  
  let title = UILabel()
  
  let image = UIImageView(image: #imageLiteral(resourceName: "buttonArrow"))
  
  let button = UIButton()
  
  init() {
    super.init(frame: CGRect.zero)
    backgroundColor = .white
    
    title.font = UIFont.brandFont(ofSize: 17.0, weight: .bold)
    title.translatesAutoresizingMaskIntoConstraints = false
    addSubview(title)
    
    button.setTitle("See All", for: .normal)
    button.titleLabel?.font = UIFont.brandFont(ofSize: 14.0)
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitleColor(.black, for: .normal)
    addSubview(button)
    
    image.translatesAutoresizingMaskIntoConstraints = false
    addSubview(image)
    
    NSLayoutConstraint.activate([
      title.centerYAnchor.constraint(equalTo: centerYAnchor),
      title.leftAnchor.constraint(equalTo: leftAnchor, constant: 26.0),
      
      image.centerYAnchor.constraint(equalTo: centerYAnchor),
      image.rightAnchor.constraint(equalTo: rightAnchor, constant: -32.0),
      
      button.centerYAnchor.constraint(equalTo: centerYAnchor),
      button.rightAnchor.constraint(equalTo: image.leftAnchor, constant: -5.0)
    ])
    
    button.setContentCompressionResistancePriority(.required, for: .vertical)
    button.setContentCompressionResistancePriority(.required, for: .horizontal)

  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}
