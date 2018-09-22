//
//  BooksCollectionController.swift
//  LittleLibrary
//
//  Created by Hongming Zuo on 2018-09-22.
//  Copyright © 2018 Hongming Zuo. All rights reserved.
//

import UIKit

class BooksCollectionController: UIViewController {

  @IBOutlet var gestureView: UIView!
  @IBOutlet var containerView: UIView!
  
  private var startY: CGFloat = 0.0
  private var endY: CGFloat = 0.0
  
  var initialOrigin = CGPoint()  // The initial center point of the view.
  
  let bookList = BookListViewController()
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    addChild(bookList)
    
    containerView.addSubview(bookList.view)
    bookList.view.pinToSuperView()
    
    view.layer.shadowColor = UIColor.black.cgColor
    view.layer.shadowOpacity = 1
    view.layer.shadowOffset = CGSize.zero
    view.layer.shadowRadius = 10
    
    gestureView.addGestureRecognizer(UIPanGestureRecognizer(target: self, action: #selector(panGesture)))
  }
  
  @objc
  func panGesture(gestureRecognizer: UIPanGestureRecognizer) {
    
    guard gestureRecognizer.view != nil else {return}
    let translation = gestureRecognizer.translation(in: view.superview)
    if gestureRecognizer.state == .began {
      self.initialOrigin = view.frame.origin
    }
    
    if gestureRecognizer.state == .ended {
      var destinationOrigin = CGRect.zero
      let middle = (startY - endY) / 2.0 + endY
      if view.frame.origin.y < middle {
        destinationOrigin = CGRect(x: 0.0, y: endY, width: view.frame.width, height: view.frame.height)
      } else {
        destinationOrigin = CGRect(x: 0.0, y: startY, width: view.frame.width, height: view.frame.height)
      }
      UIView.animate(withDuration: 0.5, delay: 0.0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.1, options: .curveEaseInOut, animations: {
        self.view.frame = destinationOrigin
      }) { _ in
      }
      return
    }
    
    if gestureRecognizer.state != .cancelled {
      var newOrigin = CGPoint(x: initialOrigin.x, y: initialOrigin.y + translation.y)
      newOrigin.y = max(newOrigin.y, endY)
      newOrigin.y = min(newOrigin.y, startY)
      view.frame = CGRect(x: newOrigin.x, y: newOrigin.y, width: view.frame.width, height: view.frame.height)
    }
    else {
      view.frame = CGRect(x: initialOrigin.x, y: initialOrigin.y, width: view.frame.width, height: view.frame.height)
    }
  }
  
  func installView(above theView: UIView, startY: CGFloat ,endY: CGFloat, height: CGFloat) {
    theView.addSubview(view)
    self.startY = startY
    self.endY = endY
    
    view.frame = CGRect(x: 0, y: self.startY, width: theView.bounds.width, height: height)
  }
}
