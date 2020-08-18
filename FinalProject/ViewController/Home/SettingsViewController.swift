//
//  ViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/10.
//

import UIKit
import AVFoundation

class SettingsViewController: AppBaseController {
    
    @IBOutlet weak var lblUserName: UILabel!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var imgProfile: UIImageView!
    var ImageHasChanged:Bool!
    var IsTakingPhoto:Bool!
    var viewModel:SettingsViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = SettingsViewModel.init()
    }
    override func viewDidAppear(_ animated: Bool) {
        if IsTakingPhoto == nil {
            self.IsTakingPhoto = false
        }
        if  !IsTakingPhoto!{
            lblUserName.text = getCurrentUser().UserName
            txtEmail.text = getCurrentUser().Email
            imgProfile.image = getCurrentUser().getUImage() ?? imgProfile.image
            ImageHasChanged = false
        }
        IsTakingPhoto = false
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    @IBAction func actionBtnChangeImage(_ sender: Any) {
        self.showConfirmAlert(ConstantUtil.UploadImageTittle, message: ConstantUtil.UploadImageMessage,
                              acceptButton: ConstantUtil.CameraOption, acceptHandler: {_ in self.openCamera()},
                              cancelButtton: ConstantUtil.GalleryOption, cancelHandler: {_ in self.openGallery()})
    }
    
    @IBAction func actionBtnSave(_ sender: Any) {
        print("UI => [Update User]")
        viewModel.UpdateUserValidate(txtEmail.text, imageHasChanged: ImageHasChanged, image: imgProfile.image, _protocol: self)
    }
    
    func openGallery(){
        print("UI => Open Gallery...")
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
        self.dismissKey()
    }
    
    func openCamera(){
        print("UI => Open Camera...")
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            self.showCamera()
        }
        else if AVCaptureDevice.authorizationStatus(for: .video) ==  .denied{
            self.showInfoAlert(ConstantUtil.ErrorDefaultTitle, message: ConstantUtil.CameraForbidPermissonMessage)            
        }else {
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (granted: Bool) in
                if granted {
                    //TODO - revisar problemas con camara en el hilo principal
                    self.showCamera()
                } 
            })
        }
    }
    
    func showCamera(){
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.sourceType = .camera;
            imagePicker.allowsEditing = true
            self.present(imagePicker, animated: true, completion: nil)
        }
        else {
            showInfoAlert(ConstantUtil.CameraUnavailableTittle, message: ConstantUtil.CameraUnavailableMessage)
        }
    }
}

extension SettingsViewController: SettingsProtocol{
    func UpdateUser(_ user:User, imageHasChanged:Bool) {
        showLoader()
        viewModel.UpdateUserApply(user, imageHasChanged: imageHasChanged, _protocol: self)
    }
    
    
    func onError(_ title: String?, message: String?) {
        print("UI => [Update User] => ERROR")
        CacheDataUtil.UserCache = getCurrentUser()
        dismissLoader({self.showErrorAlert(title, message: message)})
    }
    
    func onSuccess(_ user: User?) {
        print("UI => [Update User] => SUCCESS")
        dismissLoader({
            guard let user = user else{
                self.showDefaultError()
                return
            }
            self.setCurrentUser(user)
            self.showInfoAlert(ConstantUtil.SuccessUserUpdate)
            self.ImageHasChanged = false
            self.IsTakingPhoto = false
        })
    }
    
    func onError() {
        print("UI => [Update User] => ERROR")
        CacheDataUtil.UserCache = getCurrentUser()
        dismissLoader({self.showDefaultError()})
    }
    
    
}


extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        IsTakingPhoto = true
        ImageHasChanged = true
        if let selectedImage:UIImage = info[.editedImage] as? UIImage
        {
            imgProfile.image = selectedImage
        }
        picker.dismiss(animated: true, completion: nil)
        
    }
}
