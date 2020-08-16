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
    @IBOutlet weak var switchDummy: UISwitch!
    @IBOutlet weak var btnSignUp: UIButton!
    @IBOutlet weak var switchRememberUser: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        switchDummy.isOn = DummyUtil.IsDummyEnabled
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        if let userNameRemembered = UserDefaults.standard.string(forKey: "UserName"){
            txtUsername.text = userNameRemembered
            switchRememberUser.isOn = true
        }
    }

    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        if self.navigationController != nil{
            navigationController?.pushViewController(getViewController("Main", identifier: "CreateUserViewController"), animated: true)
        }else{
            goTo("Main", identifier: "CreateUserViewController")
        }
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
            self.login(userName: txtUsername.text, password: txtPassword.text)
        }
    }
    
    func login(userName: String?, password: String?) {
        print("UI => [Login]")
        self.showLoader()
        UserRepository.login(userName, password: password, userProtocol: self)
    }
    
    @IBAction func actionDummySwitch(_ sender: UISwitch) {
        DummyUtil.IsDummyEnabled = sender.isOn
    }
}

extension LoginViewController: LoginProtocol{
    
    func onSuccess(_ user:User) {
        print("UI => [Login] => SUCCESS")
        self.txtPassword.text = ""
        self.setCurrentUser(user)
        if switchRememberUser.isOn
        {
            UserDefaults.standard.set(user.UserName, forKey: "UserName")
        }else{
            self.txtUsername.text = ""
        }
        self.goHome()
    }
    
    func onError() {
        print("UI => [Login] => ERROR")
        self.dismissLoader({self.showDefaultError()})
    }
}

