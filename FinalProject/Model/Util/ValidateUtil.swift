//
//  ValidationUtils.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import Foundation
import RealmSwift

class ValidateUtil {
    
    static func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
