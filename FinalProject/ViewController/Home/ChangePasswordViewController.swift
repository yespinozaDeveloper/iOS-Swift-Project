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
    
    @IBAction func actionChangePassword(_ sender: Any) {
        var tittle:String?
        var message:String = ""
        if txtCurrentPassword.text == ""
        {
            message = ConstantUtil.CurrentPasswordRequiredMessage
        }
        else if txtNewPassword.text == ""
        {
            message = ConstantUtil.NewPasswordRequiredMessage
           
        }
        else if txtNewPassword2.text == ""
        {
            message = ConstantUtil.ConfirmPasswordRequiredMessage
           
        }
        else if txtNewPassword.text != txtNewPassword2.text
        {
            tittle = ConstantUtil.PasswordNotMatchTittle
            message = ConstantUtil.PasswordNotMatchMessage
        }
        else if txtCurrentPassword.text == txtNewPassword.text
        {
            tittle = ConstantUtil.SamePasswordTittle
            message = ConstantUtil.SamePasswordMessage
        }
        
        if message != ""
        {
            self.showInfoAlert(tittle, message:message)
        }
        else{
            showConfirmAlert(ConstantUtil.ChangePasswordConfirmationMessage, acceptButton: ConstantUtil.ChangeOption, acceptHandler: {_ in self.changePassword()})
        }
    }
    
    @IBAction func actionCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    func changePassword(){
        print("UI => [Change Password] => SUCCESS")
        showLoader()
        UserRepository.changePassword(getCurrentUser().UserName, currentPassword: txtCurrentPassword.text, newPassword: txtNewPassword.text, userProtocol: self)
    }
    
    func clearForm(){
        txtCurrentPassword.text = ""
        txtNewPassword.text = ""
        txtNewPassword2.text = ""
    }
}

extension ChangePasswordViewController: UserProtocol{
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
