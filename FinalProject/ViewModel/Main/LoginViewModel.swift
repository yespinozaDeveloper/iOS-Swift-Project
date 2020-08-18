//
//  LoginViewModel.swift
//  FinalProject
//
//  Created by yespinoza on 8/18/20.
//

import Foundation

struct LoginViewModel{
    
    func LoginValidate(_ userName:String?, password:String?, _protocol:LoginProtocol){
        
        let validation = loginValidation(userName, password: password)
        
        if validation.isSuccessful {
            _protocol.login(userName!, password: password!)
        }
        else{
            _protocol.onError(validation.title, message: validation.message)
        }
    }
    
    func LoginApply(_ userName:String?, password:String?, rememberUser:Bool, rememberPassword:Bool, _protocol:LoginProtocol){
        UserRepository.login(userName, password: password, _protocol: _protocol)
    }
    
    func SaveUserDefaults(_ userName:String?, password:String?, rememberUser:Bool, rememberPassword:Bool){
        if rememberUser {
            UserDefaults.standard.set(userName!, forKey: "UserName")
            if rememberPassword {
                UserDefaults.standard.set(password, forKey: "Password")
            }
        }else{            
            UserDefaults.standard.removeObject(forKey: "UserName")
            UserDefaults.standard.removeObject(forKey: "Password")
        }
    }
    
    func loginValidation(_ userName:String?, password:String?) -> ViewModelValidation{
        
        var message:String = ""
        
        if userName == nil || userName == ""
        {
            message = ConstantUtil.UserRequiredMessage
        }
        else if password == nil || password == ""
        {
            message = ConstantUtil.PasswordRequiredMessage
        }
        
        return ViewModelValidation.init(isSuccessful: message == "", title: ConstantUtil.ErrorDefaultTitle, message: message)
    }
}
