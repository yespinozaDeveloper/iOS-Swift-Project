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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgProfile.layer.borderWidth = 1.0
        imgProfile.layer.masksToBounds = false
        imgProfile.layer.borderColor = UIColor.white.cgColor
        imgProfile.layer.cornerRadius = imgProfile.frame.size.width / 2
        imgProfile.clipsToBounds = true
        lblUserName.text = getCurrentUser().UserName
        lblEmail.text = getCurrentUser().Email
        imgProfile.image = getCurrentUser().getUImage() ?? imgProfile.image
    }
    
    override func viewDidAppear(_ animated: Bool) {
        lblUserName.text = getCurrentUser().UserName
        lblEmail.text = getCurrentUser().Email
        imgProfile.image = getCurrentUser().getUImage() ?? imgProfile.image
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    @IBAction func actionAppointment(_ sender: Any) {
        goToAppointment()
    }
    @IBAction func actionHistory(_ sender: Any) {
        tabBarController?.selectedIndex = 0
    }
    @IBAction func actionSettings(_ sender: Any) {
        tabBarController?.selectedIndex = 2
    }
}
