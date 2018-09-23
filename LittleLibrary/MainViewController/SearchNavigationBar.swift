//
//  SearchNavigationBar.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import Foundation
import UIKit

class SearchNavigationBar: UIView {
  
  @IBOutlet var subTitle: UILabel!
  @IBOutlet var searchField: UITextField!
  @IBOutlet var icon: UIImageView!

  var status: SearchStatus = .hide {
    didSet {
      switch status {
      case .doSearch:
        icon.image = #imageLiteral(resourceName: "arrow")
      case .hide:
        icon.image = #imageLiteral(resourceName: "search")
      }
    }
  }

  weak var searchVC: BookSearchResultController?
  
  override func awakeFromNib() {
    super.awakeFromNib()
    backgroundColor = UIColor.brandBlue
    searchField.delegate = self
  }
  
  @IBAction func buttonClick() {
    if status == .doSearch {
      UIView.animate(withDuration: 0.3) {
        self.searchVC?.view.alpha = 0.0
      }
      searchField.resignFirstResponder()
      status = .hide
    }
  }
  
}

extension SearchNavigationBar: UITextFieldDelegate {
  
  enum SearchStatus {
    case hide
    case doSearch
  }
  
  func textFieldDidBeginEditing(_ textField: UITextField) {
    status = .doSearch
    UIView.animate(withDuration: 0.3) {
      self.searchVC?.view.alpha = 1.0
    }
  }
  
  func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
    
    if let text = textField.text {
      if text.isEmpty {
        self.searchVC?.status = .recommand
      }
    }
    
    return true
  }
  
  
  func textFieldShouldReturn(_ textField: UITextField) -> Bool {
    textField.resignFirstResponder()
    self.searchVC?.books = []
    return true
  }
  
}
