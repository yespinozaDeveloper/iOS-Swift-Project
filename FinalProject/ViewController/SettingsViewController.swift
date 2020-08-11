//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit

class SettingsViewController: AppBaseController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    
    override func viewDidAppear(_ animated: Bool) {
        lblUserName.text = getCurrentUser().UserName
        txtEmail.text = getCurrentUser().Email
        imgProfile.image = getCurrentUser().getUImage() ?? imgProfile.image
        
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    @IBAction func actionBtnChangeImage(_ sender: Any) {
    }
    @IBAction func actionBtnSave(_ sender: Any) {
        var title:String?
        var message:String = ""
        if txtEmail.text == ""
        {
            message = ConstantUtil.EmailRequiredMessage
           
        }
        else if !ValidateUtil.isValidEmail(txtEmail.text!){
            title = ConstantUtil.WrongEmailTittle
            message = ConstantUtil.WrongEmailMessage
        }
        if message != ""
        {
            showInfoAlert(title, message: message)
        }
        else{
            uploadUser()
        }
    }
    
    func uploadUser(){
        showLoader()
        print("Save Email...")
        dismissLoader({
            var currentUser:User = self.getCurrentUser()
            currentUser.Email = self.txtEmail.text!
            self.setCurrentUser(currentUser)
            self.showInfoAlert(ConstantUtil.SuccessUserUpdate)
        })
    }
}
