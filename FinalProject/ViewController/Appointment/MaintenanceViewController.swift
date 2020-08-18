//
//  MaintenanceViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/12
//

import UIKit

class MaintenanceViewController: AppBaseController {
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var actionBtnLocation: UIButton!
    @IBOutlet weak var txtReason: UITextView!
    var SelectedAppointment:Appointment?
    var delegate:AppointmentProtocol?
    
    override func viewDidLoad() {
        if let appointment = SelectedAppointment{
            
            datePicker.date = appointment.getDate()
            txtReason.text = appointment.Reason
            actionBtnLocation.setTitle(appointment.Place, for: .normal)
            if appointment.getDate() < Date.init()
            {
                datePicker.minimumDate = appointment.getDate()
            }else{
                datePicker.minimumDate = Date.init()
            }
            
        }else{
            datePicker.minimumDate = Date.init()
        }
    }
    
    @IBAction func actionBtnSave(_ sender: Any) {
        let date:Date = datePicker.date
        let userName:String = getCurrentUser().UserName
        let location:String? = actionBtnLocation.titleLabel?.text
        let reason:String = txtReason.text
        
        guard let _ = location, location != "", location?.trimmingCharacters(in: .whitespacesAndNewlines) != "Select location" else {
            showInfoAlert(ConstantUtil.LocationRequiredMessage)
            return
        }
        if reason == ""{
            showInfoAlert(ConstantUtil.ReasonRequiredMessage)
        }else{
            print("UI => [Save Appointment]")
            showLoader()
            if let appointment = SelectedAppointment{
                AppointmentRepository.update(getCurrentUser().UserName, oldDate: appointment.getDate(), newDate: datePicker.date, location: location!, reason: reason, _protocol: self)
            }else{
                AppointmentRepository.save(userName, date: date, location: location!, reason: reason, _protocol: self)
            }
        }
    }
    @IBAction func actionBtnCancel(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func actionBtnLocation(_ sender: Any) {
        let viewController:LocationSelectionViewController = getViewController("Appointment", identifier: "LocationSelectionViewController")
        viewController.delegate = self
        goTo(viewController)
    }
}

extension MaintenanceViewController : LocationProtocol{
    func onSelect(_ location: String) {
        print("UI => [Select Location] => SUCCESS")
        SelectedAppointment?.Place = location
        actionBtnLocation.setTitle(location, for: .normal)
    }
}

extension MaintenanceViewController : SaveAppointmentProtocol{
    
    func onSuccess() {
        print("UI => [Save Appointment] => SUCCESS")
        dismissLoader({self.showInfoAlert(ConstantUtil.SuccessAppointmentSave,
                                          acceptHandler: { _ in self.dismiss(animated: true)}
            )})
        delegate?.onUpdateSuccess()
    }
    
    func onError(_ message:String)  {
        print("UI => [Save Appointment] => HANDLED ERROR")
        dismissLoader({self.showInfoAlert(ConstantUtil.ErrorDefaultTitle, message:message)})
    }
    
    func onError() {
        print("UI => [Save Appointment] => ERROR")
        dismissLoader({self.showDefaultError()})
    }
    
    
}
