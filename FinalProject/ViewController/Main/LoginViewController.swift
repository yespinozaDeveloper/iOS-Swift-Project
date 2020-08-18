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
    var viewModel:LoginViewModel!
    var hasChanged:Bool = false
    var savePassword:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LoginViewModel.init()
        initViewController()
    }
    
    func initViewController(){
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        if let userNameRemembered = UserDefaults.standard.string(forKey: "UserName"){
            switchRememberUser.isOn = true
            txtUsername.text = userNameRemembered
            if let passwordRemembered = UserDefaults.standard.string(forKey: "Password"){
                savePassword = true
                txtPassword.text = passwordRemembered
            }
        }
        DummyUtil.IsDummyEnabled = UserDefaults.standard.bool(forKey: "IsDummyEnabled")
        switchDummy.isOn = DummyUtil.IsDummyEnabled
    }
    
    @objc func handleSwipes(_ sender:UISwipeGestureRecognizer)
    {
        if self.navigationController == nil{
            goTo("Main", identifier: "CreateUserViewController")
        }else{
            navigationController?.pushViewController(getViewController("Main", identifier: "CreateUserViewController"), animated: true)
        }
    }
    
    @IBAction func actionHasChanged(_ sender: Any) {
        hasChanged = true
        switchRememberUser.isOn = false
        savePassword = false
    }
    
    @IBAction func actionLogin(_ sender: Any) {
        print("UI => [Login]")
        viewModel.LoginValidate(txtUsername.text, password: txtPassword.text, _protocol:self)
    }
    
    @IBAction func actionDummySwitch(_ sender: UISwitch) {
        DummyUtil.IsDummyEnabled = sender.isOn
        UserDefaults.standard.set(sender.isOn, forKey: "IsDummyEnabled")
    }
    @IBAction func actionRemberSwitch(_ sender: UISwitch) {
        self.savePassword = false
        if sender.isOn {
            showConfirmAlert(ConstantUtil.RememberPasswordConfirmationMessage, acceptButton: ConstantUtil.AcceptOption) { _ in
                self.savePassword = true
            }
        }
    }
}

extension LoginViewController: LoginProtocol{
    func login(_ userName:String, password:String) {
        self.showLoader()
        viewModel.LoginApply(userName, password: password, rememberUser:switchRememberUser.isOn, rememberPassword: savePassword,_protocol: self)
    }    
    
    func onSuccess(_ user:User) {
        print("UI => [Login] => SUCCESS")
        viewModel.SaveUserDefaults(user.UserName, password: txtPassword.text, rememberUser: switchRememberUser.isOn, rememberPassword: savePassword)
        self.setCurrentUser(user)
        if switchRememberUser.isOn && !savePassword
        {
            self.txtPassword.text = ""
        }else{
            self.txtUsername.text = ""
            self.txtPassword.text = ""
        }
        self.goHome()
    }
    
    func onError() {
        print("UI => [Login] => ERROR")
        self.dismissLoader({self.showDefaultError()})
    }
    
    func onError(_ title: String?, message: String?) {
        print("UI => [Login] => ERROR")
        dismissLoader({ self.showErrorAlert(title, message: message) })
    }
}

