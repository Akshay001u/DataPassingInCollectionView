//
//  ViewController.swift
//  DataPassingInCollectionView
//
//  Created by Akshay on 15/04/1944 Saka.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var EmployeeCollectionView: UICollectionView!

    @IBOutlet weak var deleteButton: UIBarButtonItem!
    
    var employee1 : [Employee] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        EmployeeCollectionView.dataSource = self
        EmployeeCollectionView.delegate = self
        navigationItem.title = "Employee Data"
        
        
        let uiNib = UINib(nibName: "CustomCollectionViewCell", bundle: nil)
        self.EmployeeCollectionView.register(uiNib, forCellWithReuseIdentifier: "CustomCell")
    }
    
    @IBAction func addEmployeeDataBtn(_ sender: Any) {
        let secondViewController = self.storyboard?.instantiateViewController(identifier: "SecondViewController")as? SecondViewController
        secondViewController?.delegateSVC = self
        self.navigationController?.pushViewController(secondViewController!, animated: true)
    }
    
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
        EmployeeCollectionView.allowsMultipleSelection = editing
        deleteButton.isEnabled = editing
       
        EmployeeCollectionView.indexPathsForVisibleItems.forEach{(indexpath) in
            let cell = EmployeeCollectionView.cellForItem(at: indexpath) as! CustomCollectionViewCell
            cell.isEditing = editing
            }
        }
    
    @IBAction func deleteEmployeeDataBtn(_ sender: Any) {
        if let selectedItems = EmployeeCollectionView.indexPathsForSelectedItems {
            let items = selectedItems.map{$0.item}.sorted().reversed()
            for item in items{
                employee1.remove(at: item)
            }
            EmployeeCollectionView.deleteItems(at: selectedItems)
        }
    }
    
}

    
extension ViewController : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        employee1.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let employeeCell = self.EmployeeCollectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath)as! CustomCollectionViewCell
        let eachEmployee = employee1[indexPath.row]
        employeeCell.EmployeeIdLabel.text = eachEmployee.Id
        employeeCell.EmployeeNameLabel.text = eachEmployee.Name
        employeeCell.EmployeeCityLabel.text = eachEmployee.City
        employeeCell.EmployeeStateLabel.text = eachEmployee.State
        return employeeCell
    }
}


extension ViewController : UICollectionViewDelegate{
    
}


extension ViewController: UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let collectionwidth = collectionView.bounds.width
        return CGSize(width: collectionwidth/2, height: collectionwidth/2)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}


extension ViewController : EmployeeDataPassingProtocol{
    func passEmployeeData(myemployee: Employee) {
        let myemployee = Employee(Id: myemployee.Id, Name: myemployee.Name, City: myemployee.City, State: myemployee.State)
        employee1.append(myemployee)
        EmployeeCollectionView.reloadData()
    }
}
