//
//  SecondViewController.swift
//  DataPassingInCollectionView
//
//  Created by Akshay on 15/04/1944 Saka.
//

import UIKit

class SecondViewController: UIViewController {

    
    @IBOutlet weak var EmployeeIdTextField: UITextField!
    
    @IBOutlet weak var EmployeeNameTextField: UITextField!
    
    @IBOutlet weak var EmployeeCityTextField: UITextField!
    
    @IBOutlet weak var EmployeeStateTextField: UITextField!
    
    
    var delegateSVC : EmployeeDataPassingProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func SaveDataButton(_ sender: Any) {
        guard let delegate = delegateSVC else{
            return
        }
        
        if self.EmployeeIdTextField.text! .isEmpty || self.EmployeeNameTextField.text! .isEmpty || self.EmployeeCityTextField.text! .isEmpty || self.EmployeeStateTextField.text! .isEmpty{
            
        let alertController = UIAlertController(title: "", message: "Please Enter All Details", preferredStyle: .alert)
            
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                    UIAlertAction in
                    NSLog("OK Pressed")
                }
        // Add the actions
        alertController.addAction(okAction)
            
        // Present the controller
        self.present(alertController, animated: true, completion: nil)
            
        }

        else{
        let employeeIdToPass = self.EmployeeIdTextField.text ?? ""
        let employeeNameToPass = self.EmployeeNameTextField.text ?? ""
        let employeeCityToPass = self.EmployeeCityTextField.text ?? ""
        let employeeStateToPass = self.EmployeeStateTextField.text ?? ""
        
        let employeeObjectToPass = Employee(Id: employeeIdToPass, Name: employeeNameToPass, City: employeeCityToPass, State: employeeStateToPass)
        
        delegate.passEmployeeData(myemployee: employeeObjectToPass)

        let alertController = UIAlertController(title: "", message: "Data saved Successfully", preferredStyle: .alert)
    
        // Create the actions
        let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { 
                    UIAlertAction in
                    NSLog("OK Pressed")
        self.navigationController?.popViewController(animated: true)
                }

        // Add the actionsZAQSSDXEE4E3W4E3W243EW2DSWQESZWSAEASZSSXZS
        alertController.addAction(okAction)
        
        // Present the controller
        self.present(alertController, animated: true, completion: nil)

        }
    }
}
