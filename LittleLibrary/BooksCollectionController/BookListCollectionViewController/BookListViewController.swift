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
  
  let collectionView = BooksCollectionView()
  
  override func viewDidLoad() {
      super.viewDidLoad()

  }

}
