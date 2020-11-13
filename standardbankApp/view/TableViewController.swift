//
//  TableViewController.swift
//  standardbankApp
//
//  Created by Clive Ngobeni on 2020/10/29.
//

import UIKit

class TableViewController: UIViewController {
    
    @IBOutlet var navBar: UINavigationBar!
    @IBOutlet var authTableView: UITableView!
    
    var authNames = [viewModelApp]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        displayAuthMethods()
        self.navigationItem.hidesBackButton = true
        authTableView.dataSource = self
        authTableView.delegate = self
    }
}


extension TableViewController: UITableViewDelegate,UITableViewDataSource {
    // it is an array that displays a list of different authMethods on the table view screen
    func displayAuthMethods(){
        let fingerIDAuthenticationMethod  = viewModelApp(authName:"Using fingerprint")
        authNames.append(fingerIDAuthenticationMethod)
        
        let voiceRegcognitionAuthenticationMethod  = viewModelApp(authName:"Voice recognition")
        authNames.append(voiceRegcognitionAuthenticationMethod)
        
        let faceIDAuthenticationMethod  = viewModelApp(authName:"Face recognition")
        authNames.append(faceIDAuthenticationMethod)
        
        let digitAuthenticationMethod  = viewModelApp(authName:"With a 4-digit PIN")
        authNames.append(digitAuthenticationMethod)
        
        authNames.shuffle()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return authNames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "authCell")
        
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: "authCell")
        }
        
        cell?.textLabel?.text = authNames[indexPath.row].authName
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        
        performSegue(withIdentifier: "showDetail", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            destination.authMethod = authNames[(authTableView.indexPathForSelectedRow?.row)!]
            authTableView.deselectRow(at: authTableView.indexPathForSelectedRow!, animated: true)
        }
    }
}
