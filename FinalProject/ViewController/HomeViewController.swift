//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit

class HomeViewController : AppBaseController{
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        lblUserName.text = getCurrentUser().UserName
        lblEmail.text = getCurrentUser().Email
        imgProfile.image = getCurrentUser().getUImage() ?? imgProfile.image
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    @IBAction func actionAppointment(_ sender: Any) {
    }
    @IBAction func actionHistory(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    @IBAction func actionSettings(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
}
