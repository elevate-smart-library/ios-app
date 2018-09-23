//
//  BookDetailController.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-23.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import UIKit
import SDWebImage

class BookDetailController: UIViewController {

  @IBOutlet var navigationHeigh: NSLayoutConstraint!
  @IBOutlet var navBar: UIView!
  @IBOutlet var scrollView: UIScrollView!
  @IBOutlet var headerView: UIView!
  
  @IBOutlet var bookName: UILabel!
  @IBOutlet var bookAuthor: UILabel!
  @IBOutlet var bookImage: UIImageView!

  @IBOutlet var address: UIView!
  @IBOutlet var addressLabel: UILabel!
  
  @IBOutlet var summury: UIView!

  @IBOutlet var rattingContainer: UIView!
  
  let ratting = Ratting()
  
  var book: Book?
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    if let book = book {
      bookImage.sd_setImage(with: URL(string: book.pictureUrl), completed: nil)
      bookName.text = book.title
      bookAuthor.text = book.author
      addressLabel.text = book.library?.location.address ?? ""
      ratting.ratting = book.avageReview
    }
  }
  
  let stackView = UIStackView()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    navBar.backgroundColor = UIColor.brandBlue
    scrollView.contentInsetAdjustmentBehavior = .never
    stackView.axis = .vertical
    stackView.alignment = .fill
    stackView.distribution = .equalSpacing
    
    rattingContainer.addSubview(ratting)
    ratting.pinToSuperView()
    
    bookImage.addShadow(color: UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.16),  offSet: CGSize(width: 0.0, height: 7.0), radius: 9.0)
    
    stackView.addArrangedSubview(headerView)
    stackView.addArrangedSubview(address)
    stackView.addArrangedSubview(summury)
    
    stackView.translatesAutoresizingMaskIntoConstraints = false
    
    scrollView.addSubview(stackView)
    
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
      stackView.leftAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leftAnchor),
      stackView.rightAnchor.constraint(equalTo: scrollView.frameLayoutGuide.rightAnchor),
      stackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
    ])
    
    
    
    if let saftInset = UIApplication.shared.delegate?.window??.safeAreaInsets {
      navigationHeigh.constant = saftInset.top + 44.0
      var currentInset = scrollView.contentInset
      currentInset.top = saftInset.top + 44.0
      scrollView.contentInset = currentInset
    }
    
  }
  
  override func viewDidLayoutSubviews() {
    super.viewDidLayoutSubviews()
    
  }
  
  @IBAction func dismissView() {
    self.dismiss(animated: true, completion: nil)
  }

}
