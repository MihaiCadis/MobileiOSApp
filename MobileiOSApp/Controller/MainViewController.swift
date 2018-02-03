//
//  ViewController.swift
//  MobileiOSApp
//
//  Created by Cadis Mihai on 17/01/2018.
//  Copyright © 2018 Cadis Mihai. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import MessageUI

class MainViewController: UITableViewController, MFMailComposeViewControllerDelegate {
    
    let cellId = "cellId"
    var users = [User]()
    let layout:UICollectionViewFlowLayout = UICollectionViewFlowLayout.init()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        checkIfUserIsLoggedIn()
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Log out", style: .plain, target: self, action: #selector(handleLogOut))
        tableView.register(UserCell.self, forCellReuseIdentifier: cellId)
        fetchUsers()
    }
    
    
    
    // Sets the navigation bar Title
    
    func fetchUserAndSetupNavBarTitle() {
        
        guard let uid = Auth.auth().currentUser?.uid else {
            return
        }
        
        Database.database().reference().child("users").child(uid).observeSingleEvent(of: .value) { (snapshot) in
            if let userDictionary = snapshot.value as? [String: AnyObject] {
                self.navigationItem.title = userDictionary["name"] as? String
                
            
                let user = User()
            
                user.name = userDictionary["name"] as? String
                
                self.setNavBarWithUser(user)
            
        }
        }
    }
    func setNavBarWithUser(_ user: User){
        
        let titleView = UIButton()
        titleView.translatesAutoresizingMaskIntoConstraints = false
        titleView.setTitle(user.name!, for: .normal)
        titleView.setTitleColor(UIColor.black, for: .normal)
        titleView.frame = CGRect(x: 0, y: 0, width: 150, height: 40)
       // titleView.backgroundColor = UIColor.red
        
        
        self.navigationItem.titleView = titleView
        
        titleView.addTarget(self, action: #selector(handleShowChart), for: .touchUpInside)
    }
    
    

    
    // Checks if any users are logged in at launch time, if not ,proceeds to login/register
    
    
    func checkIfUserIsLoggedIn(){
        if Auth.auth().currentUser?.uid == nil {
            perform(#selector(handleLogOut), with: nil, afterDelay: 0)
        }
        else {
            fetchUserAndSetupNavBarTitle()
        }
        
        
    }
    
    
    // Fetches all the users registered in the database
    
    func fetchUsers() {
        
        Database.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            
            
            
            if let userDictionary = snapshot.value as? [String: AnyObject] {
                let user = User()
                user.id = snapshot.key
                user.name = userDictionary["name"] as? String
                user.email = userDictionary["email"] as? String
                
               
                
                self.users.append(user)
                
                DispatchQueue.main.async(execute: {self.tableView.reloadData() })
              
            }
        }, withCancel: nil)
        
        
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath ) as! UserCell
        let user = users[indexPath.row]
        cell.textLabel?.text = user.name
        cell.detailTextLabel?.text = user.email
        
        

    
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let user = users[indexPath.row]
        handleSendEmailTo(user)
        
    }
    
    
    
    // Handlers
    @objc func handleLogOut() {
        do {
            try Auth.auth().signOut()
        } catch let logoutError {
            print(logoutError)
        }
        let loginController = LoginRegisterViewController()
        loginController.mainController = self
        present(loginController, animated: true, completion: nil)
    }
    
    @objc func handleShowChart() {
        let chartController = BarChartController(collectionViewLayout: layout)
        present(chartController, animated: true, completion: nil)
        
        
    }
    
    func handleSendEmailTo(_ user: User) {
        let mailComposeViewController = configureMailController(user)
        if MFMailComposeViewController.canSendMail() {
             self.present(mailComposeViewController, animated: true, completion: nil)
        } else {
            showMailError()
        }
    }
   

    func configureMailController(_ user: User) -> MFMailComposeViewController {
        let mailComposerVC = MFMailComposeViewController()
        mailComposerVC.delegate = self as? UINavigationControllerDelegate

        mailComposerVC.setToRecipients([user.email!])
        mailComposerVC.setSubject("Hi")
        mailComposerVC.setMessageBody("\(user.name!), what have you been up to?", isHTML: false)
        
        
        return mailComposerVC
    }

    func showMailError() {
        let sendMailErrorAlert = UIAlertController(title: "Could not send email", message: "Your device could not send email", preferredStyle: .alert)
        let dismiss = UIAlertAction(title: "Ok", style: .default, handler: nil)
        
        sendMailErrorAlert.addAction(dismiss)
        self.present(sendMailErrorAlert, animated: true, completion: nil )
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        controller.dismiss(animated: true, completion: nil)
    }
}





