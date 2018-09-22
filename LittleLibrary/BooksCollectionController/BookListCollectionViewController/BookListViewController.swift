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
  
  let background = BackgroundView()
  
  let bookType = BookTypeSelection()
  
  let justAddHeader = BookListHeader()
  let justAddBooks = BooksCollectionView()
  
  let recommandHeader = BookListHeader()
  let recommandBooks = BooksCollectionView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    if let touchView = view as? TouchThrowView {
      touchView.shouldReactorToHit = { point, view in
        if view == self.scrollView {
          return false
        }
        return true
      }
    }
    
    scrollView.showsVerticalScrollIndicator = false
    
    background.backgroundColor = .white
    background.layer.cornerRadius = 25.0
    
    scrollView.addSubview(background)
    
    
    bookType.frame = CGRect(x: 16.0, y: 30.0, width: view.frame.width - 16.0 * 2.0, height: BookTypeSelection.Design.defaultHeight)
    
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
    
    scrollView.contentInset = UIEdgeInsets(top: 400.0, left: 0.0, bottom: 0.0, right: 0.0)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    var contentSize = scrollView.contentSize
    contentSize.width = view.frame.width
    contentSize.height = recommandBooks.frame.maxY
    scrollView.contentSize = contentSize
    
    background.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: contentSize.height + 1000.0)
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

class BackgroundView: UIView {
  
  let node = UIView()
  
  init() {
    super.init(frame: CGRect.zero)
    node.backgroundColor = UIColor.brandGreyColor
    addSubview(node)
    node.layer.cornerRadius = 3.0
    
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    let theFrame = self.frame
    let width: CGFloat = 58.0
    let heigh: CGFloat = 6.0
    node.frame = CGRect(x: (theFrame.width - width) / 2.0, y: 13.0, width: width, height: heigh)
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


