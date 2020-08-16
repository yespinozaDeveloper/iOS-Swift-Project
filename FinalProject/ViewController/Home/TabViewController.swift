//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/09
//

import UIKit

class TabViewController : UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.selectedIndex = 1
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)        
    }

    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        if sender.direction == .left {
            if self.selectedIndex != 2 {
                self.selectedIndex += 1
            }else{
                self.selectedIndex = 0
            }
        }
        else if sender.direction == .right {
            if self.selectedIndex != 0 {
                self.selectedIndex -= 1
            }else{
               self.selectedIndex = 2
            }
        }
    }
}
