//
//  ViewController.swift
//  SyncContactUIApp
//
//  Created by SANISH PAUL on 01/08/22.
//

import UIKit
import Contacts


struct ContactModel{
    var full_name: String
    var phone_number: String
}
class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var contactList = [ContactModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.fetchContactdata()
    }
                       
    private func fetchContactdata()
    {
        let store = CNContactStore()
        
        store.requestAccess(for: .contacts){ (granted,err) in
            
            if let err = err
            {
                print("Failed to request access permission",err)
                return
            }
            
            if granted
            {
                print("Access granted permission")
                let keys = [CNContactGivenNameKey, CNContactFamilyNameKey,CNContactPhoneNumbersKey]
                
                let request = CNContactFetchRequest(keysToFetch: keys as [CNKeyDescriptor])
                
                do
                {
                    request.sortOrder = CNContactSortOrder.userDefault
                    
                    try store.enumerateContacts(with: request, usingBlock:
                        {(contact,stoppointerIfYouWantToStopEnumerating) in

                        let phone_number = contact.phoneNumbers.first?.value.stringValue ?? " "
                        
                        if phone_number != ""
                        {
                            
                            let full_name = contact.givenName + " " + contact.familyName
                            
                            let contact_model = ContactModel(full_name: full_name, phone_number: phone_number)
                            
                            self.contactList.append(contact_model)
                        }
                    })
                    self.tableView.reloadData()
                }catch let err{
                    print("Failed to get Contact",err)
                }
            }
            else
            {
                print("Access denined")
            }
        }
    }
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        var message: String = "All Contacts"
        
        return message
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return contactList.count
    }

    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return CGFloat(20)
    }
                       
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var customHeight = 100 as! Int
        return CGFloat(customHeight)
    }
                       
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let rowData = self.contactList[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "tblCell", for: indexPath) as! ContactTableViewCell
        
        
        cell.nameOutlet.text = rowData.full_name
        cell.phoneOutlet.text = rowData.phone_number
        
        return cell
    }
}
