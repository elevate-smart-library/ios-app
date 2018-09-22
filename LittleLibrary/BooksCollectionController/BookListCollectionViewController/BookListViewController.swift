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
  
  let bookType = BookTypeSelection()
  
  let justAddHeader = BookListHeader()
  let justAddBooks = BooksCollectionView()
  
  let recommandHeader = BookListHeader()
  let recommandBooks = BooksCollectionView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    bookType.frame = CGRect(x: 16.0, y: 0.0, width: view.frame.width - 16.0 * 2.0, height: BookTypeSelection.Design.defaultHeight)
    
    justAddHeader.frame = CGRect(x: 0.0, y: bookType.frame.maxY, width: view.frame.width, height: BookListHeader.Design.height)
    justAddHeader.title.text = "Just Add"
    justAddBooks.frame = CGRect(x: 0.0, y: justAddHeader.frame.maxY, width: view.frame.width, height: BooksCollectionView.Design.defaultHeight)
    
    recommandHeader.frame = CGRect(x: 0.0, y: justAddBooks.frame.maxY, width: view.frame.width, height: BookListHeader.Design.height)
    recommandHeader.title.text = "Recommanded"
    recommandBooks.frame = CGRect(x: 0.0, y: recommandHeader.frame.maxY, width: view.frame.width, height: BooksCollectionView.Design.defaultHeight)

    
    scrollView.addSubview(bookType)
    
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
    static let height: CGFloat = 66.0
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


class BookTypeSelection: UIStackView {
  
  final class Design {
    static let defaultHeight: CGFloat = 113.0
  }
  
  let adults = UIButton()
  let teens = UIButton()
  let children = UIButton()
  
  init() {
    super.init(frame: CGRect.zero)
    self.axis = .horizontal
    self.alignment = .fill
    self.distribution = .fillEqually
    self.spacing = 9.0
    
    
    let buttons:[UIButton] = [adults, teens, children]
    buttons.forEach { button in
      button.layer.cornerRadius = 5.0
      button.titleLabel?.numberOfLines = 2
      button.titleLabel?.textAlignment = .center
      button.titleLabel?.font = UIFont.brandFont(ofSize: 15.0, weight: .bold)
    }
    
    adults.setTitle("For\nAdults", for: .normal)
    adults.backgroundColor = UIColor.brandAdultGreen
    
    teens.setTitle("For\nTeens", for: .normal)
    teens.backgroundColor = UIColor.brandTeensOrange

    
    children.setTitle("For\nChildren", for: .normal)
    children.backgroundColor = UIColor.brandChildBlue

    addArrangedSubview(adults)
    addArrangedSubview(teens)
    addArrangedSubview(children)
  }
  
  @available(*, unavailable)
  required init(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
