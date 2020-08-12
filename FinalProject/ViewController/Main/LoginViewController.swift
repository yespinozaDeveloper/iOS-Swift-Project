//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/08
//

import UIKit

class LoginViewController: AppBaseController {

    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    @IBAction func actionLogin(_ sender: Any) {
        var message:String = ""
        
        if txtUsername.text == ""
        {
            message = ConstantUtil.UserRequiredMessage
        }
        else if txtPassword.text == ""
        {
            message = ConstantUtil.PasswordRequiredMessage
        }
        
        if message != "" {
            showInfoAlert(message)
        }
        else{
            //TODO - Call service
            txtUsername.text = ""
            txtPassword.text = ""
            showLoader()
            setCurrentUser(User.init(UserName: "yespinoza", Email: "yespinoza@tecnosys.net", Image: ConstantUtil.defaultImage))
            goHome()
        }
    }
    
}

