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
            createUser()
        }
    }
    
    func createUser(){
        print("Create user...")
        showLoader()
        dismissLoader({
            self.clearForm()
            self.showInfoAlert(ConstantUtil.SuccessUserCreate)
        })
    }
    
    func clearForm(){
        txtUsername.text = ""
        txtEmail.text = ""
        txtPassword.text = ""
        txtPassword2.text = ""
    }
}
