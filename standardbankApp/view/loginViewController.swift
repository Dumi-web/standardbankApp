//
//  loginViewController.swift
//  standardbankApp
//
//  Created by Clive Ngobeni on 2020/10/28.
//

import UIKit
import Firebase
import FirebaseFirestore


class loginViewController: UIViewController {
    
    
    @IBOutlet var userName: UITextField!
    @IBOutlet var errorLabel: UITextField!
    @IBOutlet var passWord: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func validateFields()-> String? {
        // check that all fields are filled in
        if userName.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" || passWord.text?.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            return "Please fill in all fields"
        }
        // check if password is secure
        let cleanedPassword = passWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if viewModelApp.isPasswordValid(_password: cleanedPassword) == false {
            return "Please make sure your password is at least 8 characters, contains a special character and a number."
        }
        return nil
    }
    
    @IBAction func signInTapped(_ sender: UIButton) {
        
        let email = userName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        let password = passWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        
        // check if user has signed in with the same email and password.
        Auth.auth().signIn(withEmail: email, password: password) { (authResult, error) in
            if error != nil {
                return
            }
            
            // transition to tableview screen when user successfully signed in.
            else {
                self.transitionToTableViewScreen()
            }
        }
        // validate the fields
        let error = validateFields()
        if error != nil {
            // there was an error and show error message
            showError(error!)
        }
        else {
            let email = userName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            let password = passWord.text!.trimmingCharacters(in: .whitespacesAndNewlines)
            // create user
            Auth.auth().createUser(withEmail: email, password: password) { (result, err) in
                // check for errors
                if err != nil {
                    // there is an error creating a user
                    self.showError("Error creating user, either email or password is invalid.")
                }
                else{
                    // save user data in cloud fire store
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: ["email": email, "password": password, "uid": result!.user.uid]) { (error) in
                        if error != nil {
                            self.showError("Error saving user data.")
                        }
                    }
                    // transition to the table view screen
                    self.transitionToTableViewScreen()
                }
            }
        }
    }
    
    func showError(_ message: String){
        errorLabel.text = message
        errorLabel.alpha = 1
    }
    
    func transitionToTableViewScreen(){
        let tableViewController = storyboard?.instantiateViewController(identifier: Constants.StoryBoard.authViewController) as? TableViewController
        view.window?.rootViewController = tableViewController
        view.window?.makeKeyAndVisible()
    }
}


