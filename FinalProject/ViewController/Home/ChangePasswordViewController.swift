//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit

class ChangePasswordViewController : AppBaseController {
    
    @IBOutlet weak var txtCurrentPassword: UITextField!
    @IBOutlet weak var txtNewPassword: UITextField!
    @IBOutlet weak var txtNewPassword2: UITextField!
    var viewModel:ChangePasswordViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = ChangePasswordViewModel.init()
    }
    
    @IBAction func actionChangePassword(_ sender: Any) {
        viewModel.ChangePasswordValidate(txtCurrentPassword.text, newPassword: txtNewPassword.text, confirmPassword: txtNewPassword2.text, _protocol:self)
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func changePassword(_ password:String, newPassword:String){
        print("UI => [Change Password] => SUCCESS")
        showLoader()
        viewModel.ChangePasswordApply(password, newPassword: newPassword, _protocol: self)
    }
    
    func clearForm(){
        txtCurrentPassword.text = ""
        txtNewPassword.text = ""
        txtNewPassword2.text = ""
    }
}

extension ChangePasswordViewController: ChangePasswordProtocol{
    func ChangePassword(_ password:String, newPassword:String) {
        showConfirmAlert(ConstantUtil.ChangePasswordConfirmationMessage, acceptButton: ConstantUtil.ChangeOption,
        acceptHandler: {_ in self.changePassword(password, newPassword: newPassword)})
    }
    
    func onError(_ title: String?, message: String?) {
        print("UI => [Change Password] => ERROR")
        dismissLoader({self.showErrorAlert(title, message: message)})
    }
    
    func onSuccess(_ user: User?) {
        print("UI => [Change Password] => SUCCESS")
        dismissLoader({
            self.clearForm()
            self.showInfoAlert(ConstantUtil.SuccessPasswordChange)
        })
    }
    
    func onError() {
        print("UI => [Change Password] => ERROR")
        dismissLoader({self.showDefaultError()})
    }
}
