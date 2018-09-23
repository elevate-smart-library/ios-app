//
//  BookTableView.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

class BookTableView: UITableView {
  
  final class Design {
    static let cellHeight: CGFloat = 195.0
  }
  
  var books: [BooksViewModel] = [BooksViewModel(), BooksViewModel(), BooksViewModel()]
  
  static let identifier: String = "BookTableCell"
  
  init() {
    super.init(frame: CGRect(x: 0.0, y: 0.0, width: UIScreen.main.bounds.width, height: 0.0), style: UITableView.Style.plain)
    register(BookTableCell.self, forCellReuseIdentifier: BookTableView.identifier)
    
    self.delegate = self
    self.dataSource = self
    
    separatorColor = .clear
  }
  
  
  @available(*, unavailable)
  required init?(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  var maxHeight: CGFloat {
    return CGFloat(books.count) * Design.cellHeight
  }
  
}

extension BookTableView: UITableViewDelegate, UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return books.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let bookCell = tableView.dequeueReusableCell(withIdentifier: BookTableView.identifier, for: indexPath) as? BookTableCell else {
      fatalError("cell error")
    }
    bookCell.selectionStyle = .none
    return bookCell
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return Design.cellHeight
  }
  
}

extension BookTableView {
  
  class BookTableCell: UITableViewCell {
    
    let containerView = UIView()
    let bookImage = UIImageView()
    let rattingView = Ratting()
    
    let bookName = UILabel()
    let author = UILabel()
    
    let viewDetailButton = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
      super.init(style: style, reuseIdentifier: reuseIdentifier)
      
      backgroundColor = .clear
      contentView.addSubview(containerView)
      contentView.backgroundColor = .clear
      containerView.backgroundColor = .clear
      
      containerView.translatesAutoresizingMaskIntoConstraints = false
      containerView.backgroundColor = .brandBookGrey
      containerView.layer.cornerRadius = 5
      
      bookImage.translatesAutoresizingMaskIntoConstraints = false
      bookImage.image = #imageLiteral(resourceName: "tempBook")
      bookImage.contentMode = .scaleAspectFit
      containerView.addSubview(bookImage)
      
      bookImage.addShadow(color: UIColor.init(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.16),  offSet: CGSize(width: 0.0, height: 7.0), radius: 9.0)
      
      bookName.translatesAutoresizingMaskIntoConstraints = false
      bookName.font = UIFont.brandFont(ofSize: 14.0, weight: .bold)
      bookName.text = "Melmoth"
      containerView.addSubview(bookName)
      
      author.translatesAutoresizingMaskIntoConstraints = false
      author.font = UIFont.brandFont(ofSize: 14.0, weight: .semibold)
      author.text = "by Sarah Perry"
      containerView.addSubview(author)

      rattingView.translatesAutoresizingMaskIntoConstraints = false
      containerView.addSubview(rattingView)
      
      rattingView.ratting = 3
      
      containerView.addSubview(viewDetailButton)
      viewDetailButton.layer.borderColor = UIColor.brandButtonBlue.cgColor
      viewDetailButton.layer.borderWidth = 1.0
      viewDetailButton.layer.cornerRadius = 5.0
      viewDetailButton.setTitle("View Details", for: .normal)
      viewDetailButton.titleLabel?.font = UIFont.brandFont(ofSize: 14.0, weight: .semibold)
      viewDetailButton.setTitleColor(UIColor.brandButtonBlue, for: .normal)
      viewDetailButton.translatesAutoresizingMaskIntoConstraints = false
      
      NSLayoutConstraint.activate([
        containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5.0),
        containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -5.0),
        containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 14.0),
        containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -14.0),
        
        bookImage.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 24.0),
        bookImage.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28.0),
        bookImage.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -28.0),
        bookImage.widthAnchor.constraint(equalToConstant: 80.0),
        
        bookName.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 28.0),
        bookName.leftAnchor.constraint(equalTo: bookImage.rightAnchor, constant: 30.0),
        bookName.rightAnchor.constraint(equalTo: containerView.rightAnchor),
        
        author.topAnchor.constraint(equalTo: bookName.bottomAnchor, constant: 10.0),
        author.leftAnchor.constraint(equalTo: bookName.leftAnchor),
        
        rattingView.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 15.0),
        rattingView.leftAnchor.constraint(equalTo: bookName.leftAnchor),
        rattingView.widthAnchor.constraint(equalToConstant: 100.0),
        rattingView.heightAnchor.constraint(equalToConstant: 20.0),
        
        viewDetailButton.leftAnchor.constraint(equalTo: author.leftAnchor),
        viewDetailButton.widthAnchor.constraint(equalToConstant: 114.0),
        viewDetailButton.heightAnchor.constraint(equalToConstant: 34.0),
        viewDetailButton.bottomAnchor.constraint(equalTo: bookImage.bottomAnchor)
      ])
      
    }
    
    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
    }
    
  }
  
}
