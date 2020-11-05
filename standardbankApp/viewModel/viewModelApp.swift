//
//  viewModelApp.swift
//  standardbankApp
//
//  Created by Clive Ngobeni on 2020/10/29.
//

import Foundation
import UIKit
class viewModelApp {
    
    var authName: String?
    
    init(authName: String?){
        self.authName = authName
    }
    // hides back button the table view screen
    func setHidesBackButton(_ hidesBackButton: Bool, animated: Bool){
        let _ = UIBarButtonItem(title: "", style: .plain, target: TableViewController.self, action: nil)
    }
    //checks if the password makes the declared regx expression
    static func isPasswordValid(_password : String) -> Bool{
        let passwordTest = NSPredicate(format: "SELF MATCHES %@","^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{7,}")
        return passwordTest.evaluate(with: _password)
    }
}

