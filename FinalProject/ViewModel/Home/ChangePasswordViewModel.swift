//
//  ChangePasswordViewModel.swift
//  FinalProject
//
//  Created by yespinoza on 8/18/20.
//

import Foundation

struct ChangePasswordViewModel{
    func ChangePasswordValidate(_ password:String?, newPassword:String?, confirmPassword:String?, _protocol:ChangePasswordProtocol){
        
        let validation = changePasswordValidation(AppBaseController.getCurrentUser().UserName, password: password, newPassword:newPassword, confirmPassword: confirmPassword)
        
        if validation.isSuccessful {
            _protocol.ChangePassword(password!, newPassword: newPassword!)
        }
        else{
            _protocol.onError(validation.title, message: validation.message)
        }
    }
    
    func ChangePasswordApply(_ password:String?, newPassword:String?, _protocol:ChangePasswordProtocol){
        UserRepository.changePassword(AppBaseController.getCurrentUser().UserName, currentPassword:password, newPassword:newPassword, _protocol:_protocol)
    }
    
    func changePasswordValidation(_ userName:String?, password:String?, newPassword:String?, confirmPassword:String?) -> ViewModelValidation{
        var title:String?
        var message:String = ""
        
        
        if password == nil || password == ""
        {
            message = ConstantUtil.CurrentPasswordRequiredMessage
        }
        else if newPassword == nil || newPassword == ""
        {
            message = ConstantUtil.NewPasswordRequiredMessage
        }
        else if confirmPassword == nil || confirmPassword == ""
        {
            message = ConstantUtil.ConfirmPasswordRequiredMessage
            
        }
        else if password == newPassword
        {
            title = ConstantUtil.SamePasswordTittle
            message = ConstantUtil.SamePasswordMessage
        }
        else if newPassword != confirmPassword
        {
            title = ConstantUtil.PasswordNotMatchTittle
            message = ConstantUtil.PasswordNotMatchMessage
        }
        
        return ViewModelValidation.init(isSuccessful: message == "", title: title, message: message)
    }
}
