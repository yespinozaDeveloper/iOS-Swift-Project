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
    
    @IBAction func actionBtnCreate(_ sender: Any) {
        //TODO - Crear lógica de Cambiar Contraseña
        var title:String?
        var message:String = ""
        if txtUsername.text == ""
        {
            message = ConstantUtil.UserRequiredMessage
        }
        else if txtEmail.text == ""
        {
            message = ConstantUtil.EmailRequiredMessage
           
        }
        else if txtPassword.text == ""
        {
            message = ConstantUtil.PasswordRequiredMessage
           
        }
        else if txtPassword2.text == ""
        {
            message = ConstantUtil.ConfirmPasswordRequiredMessage
           
        }
        else if txtPassword.text != txtPassword2.text
        {
            title = ConstantUtil.PasswordNotMatchTittle
            message = ConstantUtil.PasswordNotMatchMessage
        }
        else if !ValidateUtil.isValidEmail(txtEmail.text!){
            title = ConstantUtil.WrongEmailTittle
            message = ConstantUtil.WrongEmailMessage
        }
        
        if message != ""
        {
            showInfoAlert(title, message:message)
        }
        else{
            createUser(userName: txtUsername.text, password: txtPassword.text, email: txtEmail.text)
        }
    }
    
    func createUser(userName: String?, password: String?, email: String?) {
        print("UI => [Create User]")
        showLoader()
        UserRepository.create(userName, password: password, email: email, userProtocol: self)
    }
    
    func clearForm(){
        txtUsername.text = ""
        txtEmail.text = ""
        txtPassword.text = ""
        txtPassword2.text = ""
    }
}

extension CreateUserViewController:UserProtocol{
    
    func onSuccess(_ user: User?) {
        print("UI => [Create User] => SUCCESS")
        dismissLoader({
            self.clearForm()
            self.showInfoAlert(ConstantUtil.SuccessUserCreate)
        })
    }
    
    func onError() {
        print("UI => [Create User] => ERROR")
        dismissLoader({
            self.showDefaultError()
        })
    }
    
}
