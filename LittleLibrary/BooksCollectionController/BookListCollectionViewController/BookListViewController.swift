//
//  BookListViewController.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import UIKit

enum ViewStatus {
  case library
  case books
}

class BookListViewController: UIViewController {

  @IBOutlet var scrollView: UIScrollView!
  
  let background = BackgroundView()
  
  let commonBookInfo = BooksCommonInfos()
  
  let library = LibraryInfos()
  
  var status: ViewStatus = ViewStatus.books {
    didSet {
      UIView.animate(withDuration: 0.3) {
        self.commonBookInfo.alpha = (self.status != .books) ? 0.0 : 1.0
        self.library.alpha = (self.status != .library) ? 0.0 : 1.0
      }
      
      view.setNeedsLayout()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    status = .books
    
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
    scrollView.delegate = self
    
    scrollView.addSubview(commonBookInfo)
    scrollView.addSubview(library)
    
    scrollView.contentInset = UIEdgeInsets(top: 450.0, left: 0.0, bottom: 0.0, right: 0.0)
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    commonBookInfo.frame = CGRect(x: 0.0, y: 30.0, width: view.frame.width, height: commonBookInfo.maxHeight)
    library.frame = CGRect(x: 0.0, y: 30.0, width: view.frame.width, height: library.maxHeight)
    
    var contentSize = scrollView.contentSize
    contentSize.width = view.frame.width
    switch status {
    case .books:
      contentSize.height =  commonBookInfo.frame.maxY
    case .library:
      contentSize.height =  library.frame.maxY
    }
    
    scrollView.contentSize = contentSize
    background.frame = CGRect(x: 0.0, y: 0.0, width: view.frame.width, height: contentSize.height + 1000.0)
  }

}

extension BookListViewController: UIScrollViewDelegate {
  
  func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
    if !decelerate {
      let middleValue = (scrollView.contentInset.top - 123.0) / 2.0
      var offset = scrollView.contentOffset
      if offset.y < -123.0 && abs(offset.y + 123.0) < middleValue {
        offset.y = -123.0
        UIView.animate(withDuration: 0.3) {
          scrollView.contentOffset = offset
        }
      } else if offset.y < -123.0 {
        offset.y = -scrollView.contentInset.top
        UIView.animate(withDuration: 0.3) {
          scrollView.contentOffset = offset
        }
      }
    }
  }
  
  func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    
    if !scrollView.isDragging {
      let middleValue = (scrollView.contentInset.top - 123.0) / 2.0
      var offset = scrollView.contentOffset
      if offset.y < -123.0 && abs(offset.y + 123.0) < middleValue {
        offset.y = -123.0
        UIView.animate(withDuration: 0.3) {
          scrollView.contentOffset = offset
        }
      } else if offset.y < -123.0 {
        offset.y = -scrollView.contentInset.top
        UIView.animate(withDuration: 0.3) {
          scrollView.contentOffset = offset
        }
      }
    }
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

class LibraryInfos: UIView {
  
  let bookTable = BookTableView()
  
  let bookAvailable = UILabel()
  let address = UILabel()
  
  init() {
    super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 0.0))
    
    bookAvailable.font = UIFont.brandFont(ofSize: 17.0, weight: .bold)
    bookAvailable.textColor = UIColor.brandBookOrange
    bookAvailable.textAlignment = .center
    bookAvailable.text = "12 Books Available"
    
    address.font = UIFont.brandFont(ofSize: 14.0, weight: .semibold)
    address.textColor = UIColor.brandAddressGrey
    address.textAlignment = .center
    address.text = "473 Adelaide St W Toronto, ON M5V 1T1"

    addSubview(bookAvailable)
    addSubview(address)
    
    bookAvailable.frame = CGRect(x: 0.0, y: 0.0, width: frame.width, height: 22.0)
    address.frame = CGRect(x: 0.0, y: bookAvailable.frame.maxY + 4.0, width: frame.width, height: 22.0)
    
    addSubview(bookTable)
    bookTable.frame = CGRect(x: 0.0, y: address.frame.maxY + 10.0, width: frame.width, height: 100.0)
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    var tableFrame = bookTable.frame
    tableFrame.size.height = bookTable.maxHeight
    bookTable.frame = tableFrame
  }
  
  var maxHeight: CGFloat {
    return address.frame.maxY + bookTable.maxHeight + 20.0
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

class BooksCommonInfos: UIView {
  
  let bookType = BookTypeSelection()
  
  let justAddHeader = BookListHeader()
  let justAddBooks = BooksCollectionView()
  
  let recommandHeader = BookListHeader()
  let recommandBooks = BooksCollectionView()
  
  init() {
    super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 0.0))
    
    addSubview(bookType)
    
    addSubview(justAddHeader)
    addSubview(justAddBooks)
    
    addSubview(recommandHeader)
    addSubview(recommandBooks)
    
    bookType.frame = CGRect(x: 16.0, y: 0.0, width: frame.width - 16.0 * 2.0, height: BookTypeSelection.Design.defaultHeight)
    
    justAddHeader.frame = CGRect(x: 0.0, y: bookType.frame.maxY, width: frame.width, height: BookListHeader.Design.height)
    justAddHeader.title.text = "Just Add"
    justAddBooks.frame = CGRect(x: 0.0, y: justAddHeader.frame.maxY, width: frame.width, height: BooksCollectionView.Design.defaultHeight)
    
    recommandHeader.frame = CGRect(x: 0.0, y: justAddBooks.frame.maxY, width: frame.width, height: BookListHeader.Design.height)
    recommandHeader.title.text = "Recommanded"
    recommandBooks.frame = CGRect(x: 0.0, y: recommandHeader.frame.maxY, width: frame.width, height: BooksCollectionView.Design.defaultHeight)
  }
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  override func layoutSubviews() {
    super.layoutSubviews()
    
  }
  
  var maxHeight:CGFloat {
    return recommandBooks.frame.maxY
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


