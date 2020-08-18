//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit

class CreateUserViewController: AppBaseController {
    
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtPassword2: UITextField!
    var viewModel:CreateUserViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = CreateUserViewModel.init()
    }
    
    @IBAction func actionBtnCreate(_ sender: Any) {
        print("UI => [Create User]")
        viewModel.CreateUserValidate(txtUsername.text, email: txtEmail.text, password: txtPassword.text, confirmPassword: txtPassword2.text, _protocol: self)
    }
    
    func clearForm(){
        txtUsername.text = ""
        txtEmail.text = ""
        txtPassword.text = ""
        txtPassword2.text = ""
    }
}

extension CreateUserViewController:UserProtocol{
    func SaveUser(_ userName: String, email: String, password: String) {
        showLoader()
        viewModel.CreateUserApply(userName, email: email, password: password, _protocol:self)
    }
    
    
    func onSuccess(_ user: User?) {
        print("UI => [Create User] => SUCCESS")
        dismissLoader({
            self.clearForm()
            self.showInfoAlert(ConstantUtil.SuccessUserCreate)
        })
    }
    
    func onError() {
        print("UI => [Create User] => ERROR")
        dismissLoader({ self.showDefaultError() })
    }
    
    func onError(_ title: String?, message: String?) {
        print("UI => [Create User] => ERROR")
        dismissLoader({ self.showErrorAlert(title, message: message) })
    }
    
}
