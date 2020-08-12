//
//  AppointmentViewController.swift
//  FinalProject
//
//  Created by yespinoza on 2020/08/11.
//

import UIKit

class AppointmentViewController : AppBaseController{
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
      super.viewDidLoad()
    }
    
    @IBAction func actionBtnLogout(_ sender: Any) {
        logout()
    }
    @IBAction func actionBtnBack(_ sender: Any) {
        self.dismiss(animated: true,completion:nil)
    }
    
    @IBAction func actionBtnAddAppointment(_ sender: Any) {
        goToPopup("Appointment", identifier: "MaintenanceViewController")
    }
    
    func deleteAppointment(){
        showLoader()
        //TODO - Call service
        dismissLoader({self.showInfoAlert(ConstantUtil.SuccessAppointmentDelete)
            self.refresh()
        })
    }
}


extension AppointmentViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        15
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        self.showConfirmAlert(ConstantUtil.DeleteAppointmentTittle, message: ConstantUtil.DeleteAppointmentConfirmationMessage,
                              acceptButton: ConstantUtil.DeleteOption, acceptHandler: {_ in self.deleteAppointment()})
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:AppointmentCell = tableView.dequeueReusableCell(withIdentifier: "AppointmentCell", for: indexPath) as! AppointmentCell
        
        let date = Date()
        let dateEdited = Calendar.current.date(byAdding: .month, value: -indexPath.row, to: date)
        let formatter = DateFormatter()
        formatter.dateFormat = ConstantUtil.HistoryDateFormat

        if let dateEdited = dateEdited{
            cell.lblDate.text = formatter.string(from: dateEdited)
            cell.lblType.text = "Monthly Control"
            cell.lblPlace.text = "Alajuela"
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       let storyBoard = UIStoryboard(name: "Appointment", bundle: nil)
         let viewController = storyBoard.instantiateViewController(identifier: "MaintenanceViewController") as! MaintenanceViewController
        
        let date = Date()
        let dateEdited = Calendar.current.date(byAdding: .month, value: -indexPath.row, to: date)
        let formatter = DateFormatter()
        formatter.dateFormat = ConstantUtil.HistoryDateFormat
        if let dateEdited = dateEdited{
            var appointmentDate:String = formatter.string(from: dateEdited)
            viewController.SelectedAppointment = Appointment.init(AppointmentDate: formatter.date(from: appointmentDate) ?? date, Place: "Monthly Control", Reason: "Alajuela")
         dismissLoader({ self.present(viewController, animated: true, completion: nil)})
        }
    }
    
    func refresh(){
        print("REFRESCAR")
        self.tableView.reloadData()
    }
    
    
}
