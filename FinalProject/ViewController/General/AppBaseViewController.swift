//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit

class AppBaseController: UIViewController {

    var alert:UIAlertController!
    static var currentUser:User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dismissKey()
    }
    
    func logout(){
        showConfirmAlert(ConstantUtil.LogoutConfirmationMessage, acceptButton: ConstantUtil.LogoutOption, acceptHandler: {_ in self.goToLogin()})
    }
    
    func goToLogin(){
        showLoader()
        AppBaseController.currentUser = nil
        goTo("Main", identifier: "MainNavController")
    }
    
    func goHome(){
        goTo("Home", identifier: "TabController")
    }
    
    func goToAppointment(){
        goTo("Appointment", identifier: "AppointmentViewController")
    }
    
    func goTo(_ storyBoard:String, identifier:String){
        dismissKeyboard()
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: identifier)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        dismissLoader({ //self.dismiss(animated: false)
                        self.present(viewController, animated: true, completion: nil)})
    }
    
    func goToNavView(_ storyBoard:String, identifier:String){
        dismissKeyboard()
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: identifier)
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        dismissLoader({ //self.dismiss(animated: false)
                        self.present(viewController, animated: true, completion: nil)})
    }
    
    func goTo(_ viewController:UIViewController){
        dismissKeyboard()
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        dismissLoader({ //self.dismiss(animated: false)
                        self.present(viewController, animated: true, completion: nil)})
    }
    
    func goToPopup(_ viewController:UIViewController){
        dismissKeyboard()
        dismissLoader({ //self.dismiss(animated: false)
                        self.present(viewController, animated: true, completion: nil)})
    }
    
    func getViewController<D:UIViewController>(_ storyBoard:String, identifier:String) -> D{
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        return storyBoard.instantiateViewController(identifier: identifier) as! D
    }
    
    func goToPopup(_ storyBoard:String, identifier:String){
        dismissKeyboard()
        let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
        let viewController = storyBoard.instantiateViewController(identifier: identifier)
        dismissLoader({ //self.dismiss(animated: false)
                        self.present(viewController, animated: true, completion: nil)})
    }
    
    func goToWithNavController(_ storyBoard:String, identifier:String){
        dismissKeyboard()
                
       let storyBoard = UIStoryboard(name: storyBoard, bundle: nil)
       let viewController = storyBoard.instantiateViewController(identifier: identifier)
        let navController = UINavigationController(rootViewController: viewController)
       dismissLoader({ //self.dismiss(animated: false)
                       self.navigationController?.present(navController, animated: true, completion: nil)})
    }
    
    func showLoader(){
        dismissKeyboard()
        alert = UIAlertController(title: nil, message: ConstantUtil.LoaderMessage, preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.large
        loadingIndicator.startAnimating()
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    func dismissLoader(_ completion:(() -> Void)?){
        if let alert = self.alert{
            alert.dismiss(animated: false, completion: completion)
        }else{
            completion?()
        }
    }
    
    func setCurrentUser(_ user:User){
        AppBaseController.currentUser = user        
        CacheDataUtil.UserCache = user
    }
    
    func getCurrentUser() -> User{
        return AppBaseController.currentUser!
    }
    
    func showDefaultError(){
        showInfoAlert(ConstantUtil.ErrorDefaultTitle, message: ConstantUtil.ErrorDefaultMessage)
    }
    
    func showInfoAlert(_ message:String){
        showInfoAlert(nil, message: message)
    }
    
    func showInfoAlert(_ title:String?, message:String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: ConstantUtil.AcceptOption, style: .default, handler: nil))
        self.present(alert, animated: true)
    }
    
    func showConfirmAlert(_ title:String?, message:String, acceptButton:String, acceptHandler: ((UIAlertAction) -> Void)?, cancelButtton:String, cancelHandler: ((UIAlertAction) -> Void)?){
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: acceptButton, style: .default, handler: acceptHandler))
        alert.addAction(UIAlertAction(title: cancelButtton, style: .cancel, handler: cancelHandler))
        self.present(alert, animated: true)
    }
    
    func showConfirmAlert(_ title:String?, message:String, acceptButton:String, acceptHandler: ((UIAlertAction) -> Void)?){
        self.showConfirmAlert(title, message: message, acceptButton: acceptButton, acceptHandler: acceptHandler, cancelButtton: ConstantUtil.CancelOption, cancelHandler: nil)
    }
    
    func showConfirmAlert(_ message:String, acceptButton:String, acceptHandler: ((UIAlertAction) -> Void)?){
        self.showConfirmAlert(nil, message: message, acceptButton: acceptButton, acceptHandler: acceptHandler, cancelButtton: ConstantUtil.CancelOption, cancelHandler: nil)
    }
    
    func showConfirmAlert(_ title:String, message:String, acceptButton:String, acceptHandler: ((UIAlertAction) -> Void)?, cancelButtton:String){
        self.showConfirmAlert(title, message: message, acceptButton: acceptButton, acceptHandler: acceptHandler, cancelButtton: cancelButtton, cancelHandler: nil)
    }
    
    func showConfirmAlert(_ message:String, acceptButton:String, acceptHandler: ((UIAlertAction) -> Void)?, cancelButtton:String){
        self.showConfirmAlert(nil, message: message, acceptButton: acceptButton, acceptHandler: acceptHandler, cancelButtton: cancelButtton, cancelHandler: nil)
    }
    
    func showConfirmAlert(_ message:String, acceptButton:String, acceptHandler: ((UIAlertAction) -> Void)?, cancelButtton:String, cancelHandler:((UIAlertAction) -> Void)?){
        self.showConfirmAlert(nil, message: message, acceptButton: acceptButton, acceptHandler: acceptHandler, cancelButtton: cancelButtton, cancelHandler: cancelHandler)
    }
    
}

extension UIViewController {
    func dismissKey(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer( target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @objc func dismissKeyboard(){
    view.endEditing(true)
    }
}
