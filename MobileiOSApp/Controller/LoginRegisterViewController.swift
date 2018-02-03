//
//  LoginRegisterViewController.swift
//  MobileiOSApp
//
//  Created by Cadis Mihai on 23/01/2018.
//  Copyright © 2018 Cadis Mihai. All rights reserved.
//

import UIKit
import CoreData
import Firebase

class LoginRegisterViewController: UIViewController {

    var mainController = MainViewController()
    var savedUsers: [NSManagedObject] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 61, g: 91, b: 151)
        
        // Adding the custom views to the main View
        view.addSubview(inputContainerView)
        view.addSubview(loginRegistreButton)
        view.addSubview(loginRegisterSegmentedControl)
        
        
        
        // Setting up the custom views.
        setupInputContainerView()
        setupLoginRegisterButton()
        setupLoginRegisterSegmentedControl()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleDismissKeyboard))
        view.addGestureRecognizer(tap)
        }
    
    // Views.
    // InputContainer View
    
    let inputContainerView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.white
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.layer.cornerRadius = 5
        containerView.layer.masksToBounds = true
        return containerView
    }()
    
    let nameTextField: UITextField = {
        let nameField = UITextField()
        nameField.translatesAutoresizingMaskIntoConstraints = false
        nameField.placeholder = "Name.."
        return nameField
    }()
    
    let nameSeparatorLineView: UIView = {
        let nameSeparator = UIView()
        nameSeparator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        nameSeparator.translatesAutoresizingMaskIntoConstraints = false
        return nameSeparator
    }()
    
    let emailTextField: UITextField = {
        let emailText = UITextField()
        emailText.translatesAutoresizingMaskIntoConstraints = false
        emailText.placeholder = "Email.."
        return emailText
    }()
    
    let emailSeparatorLineView: UIView = {
        let emailSeparator = UIView()
        emailSeparator.backgroundColor = UIColor(r: 220, g: 220, b: 220)
        emailSeparator.translatesAutoresizingMaskIntoConstraints = false
        return emailSeparator
    }()
    
    let passwordTextField: UITextField = {
        let passwordText = UITextField()
        passwordText.translatesAutoresizingMaskIntoConstraints = false
        passwordText.placeholder = "Password.."
        passwordText.isSecureTextEntry = true
        return passwordText
    }()
    
    
    let loginRegistreButton: UIButton = {
        let saidButton = UIButton()
        saidButton.backgroundColor = UIColor(r: 81, g: 101, b: 161)
        saidButton.translatesAutoresizingMaskIntoConstraints = false
        saidButton.setTitle("Register", for: .normal)
        saidButton.addTarget(self, action: #selector(handleLoginRegister), for: .touchUpInside)
        saidButton.layer.cornerRadius = 10
        saidButton.layer.masksToBounds = true
        return saidButton
    }()
    
    var loginRegisterSegmentedControl: UISegmentedControl = {
        let loginRegisterControl = UISegmentedControl(items: ["Login","Register"])
        loginRegisterControl.translatesAutoresizingMaskIntoConstraints = false
        loginRegisterControl.selectedSegmentIndex = 1
        loginRegisterControl.tintColor = UIColor.white
        loginRegisterControl.addTarget(self, action: #selector(handleLoginRegisterChange), for: .valueChanged)
        return loginRegisterControl
    }()
    
    // Height constraints so the change from login - register is simplified
    var inputContainterViewHeightConstraint: NSLayoutConstraint?
    var nameTextFieldHeightConstraint: NSLayoutConstraint?
    var emailTextFieldHeightConstraint: NSLayoutConstraint?
    var passwordTextFieldHeightConstraint: NSLayoutConstraint?
    
    // Setups for the custom views
    
    func setupInputContainerView(){
        
        // Need iOS 9 constraints
        // Need x,y,height,width constraints
        
        inputContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputContainterViewHeightConstraint = inputContainerView.heightAnchor.constraint(equalToConstant: 150)
        inputContainterViewHeightConstraint?.isActive = true
        
        inputContainerView.addSubview(nameTextField)
        inputContainerView.addSubview(nameSeparatorLineView)
        inputContainerView.addSubview(emailTextField)
        inputContainerView.addSubview(emailSeparatorLineView)
        inputContainerView.addSubview(passwordTextField)
        
        // Setup nameTextField
        // Need iOS 9 constraints
        // Need x,y,height,width constraints
        nameTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputContainerView.topAnchor).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        nameTextFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 3 )
        nameTextFieldHeightConstraint?.isActive = true
        
        // Need iOS 9 constraints
        // Need x,y,height,width constraints
        
        nameSeparatorLineView.leftAnchor.constraint(equalTo: nameTextField.leftAnchor).isActive = true
        nameSeparatorLineView.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        nameSeparatorLineView.widthAnchor.constraint(equalTo: nameTextField.widthAnchor).isActive = true
        nameSeparatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        // Need iOS 9 constraints
        // Need x,y,height,width constraints
        
        emailTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 3 )
        emailTextFieldHeightConstraint?.isActive = true
        
        // Need iOS 9 constraints
        // Need x,y,height,width constraints
        
        emailSeparatorLineView.leftAnchor.constraint(equalTo: emailTextField.leftAnchor).isActive = true
        emailSeparatorLineView.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        emailSeparatorLineView.widthAnchor.constraint(equalTo: emailTextField.widthAnchor).isActive = true
        emailSeparatorLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        
        // Need iOS 9 constraints
        // Need x,y,height,width constraints
        passwordTextField.leftAnchor.constraint(equalTo: inputContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        passwordTextFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: 1 / 3 )
        passwordTextFieldHeightConstraint?.isActive = true
        
    }
    
    func setupLoginRegisterButton() {
        
        // Need iOS 9 constraints
        // Need x,y,height,width constraints
        loginRegistreButton.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
        loginRegistreButton.topAnchor.constraint(equalTo: inputContainerView.bottomAnchor, constant: 20).isActive = true
        loginRegistreButton.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegistreButton.heightAnchor.constraint(equalToConstant: 55).isActive = true
        
        
    }
    
    func setupLoginRegisterSegmentedControl() {
        
        // Need iOS 9 constraints
        // Need x,y,height,width constraints
        loginRegisterSegmentedControl.centerXAnchor.constraint(equalTo: inputContainerView.centerXAnchor).isActive = true
        loginRegisterSegmentedControl.bottomAnchor.constraint(equalTo: inputContainerView.topAnchor, constant: -12).isActive = true
        loginRegisterSegmentedControl.widthAnchor.constraint(equalTo: inputContainerView.widthAnchor).isActive = true
        loginRegisterSegmentedControl.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    
    
    // Selector Methods (handlers)
    @objc func handleLoginRegister() {
        
        if loginRegisterSegmentedControl.selectedSegmentIndex == 0 {
            handleLogin()
        }
        else {
            handleRegister()
            
        }
        
    }
    
    @objc func handleLoginRegisterChange() {
        
        let title = loginRegisterSegmentedControl.titleForSegment(at: loginRegisterSegmentedControl.selectedSegmentIndex)
        loginRegistreButton.setTitle(title, for: .normal)
        
        
        // Change the inputContainterViews height constraint if login is selected
        inputContainterViewHeightConstraint?.constant = loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 100 : 150
        
        // Change the nameTextFields height constraint if login is selected
        nameTextFieldHeightConstraint?.isActive = false
        nameTextFieldHeightConstraint = nameTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 0 : 1 / 3)
        nameTextFieldHeightConstraint?.isActive = true
        
        
        // Change the nameTextFields height constraint if login is selected
        emailTextFieldHeightConstraint?.isActive = false
        emailTextFieldHeightConstraint = emailTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1 / 2 : 1 / 3)
        emailTextFieldHeightConstraint?.isActive = true

        
        // Change the nameTextFields height constraint if login is selected
        passwordTextFieldHeightConstraint?.isActive = false
        passwordTextFieldHeightConstraint = passwordTextField.heightAnchor.constraint(equalTo: inputContainerView.heightAnchor, multiplier: loginRegisterSegmentedControl.selectedSegmentIndex == 0 ? 1 / 2 : 1 / 3)
        passwordTextFieldHeightConstraint?.isActive = true

    }
    
    func handleLogin() {
        
        guard let email = emailTextField.text , let password = passwordTextField.text else {
            
            // make pop-up alert
            
            return
        }
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            
            if error != nil {
                print(error!)
            }
            
                        self.mainController.fetchUserAndSetupNavBarTitle()
            
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    func handleRegister() {
        guard let name = nameTextField.text , let email = emailTextField.text , let password = passwordTextField.text else {
           
            // make pop up alert
            return
        }
        
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let entitty = NSEntityDescription.entity(forEntityName: "People", in: managedContext)!
        
        let person = NSManagedObject(entity: entitty, insertInto: managedContext)
        
        person.setValue(name, forKey: "name")
        person.setValue(email, forKey: "email")
        
        do {
            try managedContext.save()
            savedUsers.append(person)
        } catch let error as NSError {
            print("Could not save. \(error),\(error.userInfo)")
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (user , error) in
            
            if error != nil {
                print(error!)
                return
            }
            
            // Succesfully authenticated the user
            
            let databaseRef = Database.database().reference(fromURL: "https://mobileiosapp-78098.firebaseio.com/").child("users").child((user?.uid)!)
            let values = ["name": name, "email": email , "password": email]
            databaseRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
                
            })
            
        }
        
    }
    @objc func handleDismissKeyboard() {
        view.endEditing(true)
    }

}

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: 1)
        
    }
}





