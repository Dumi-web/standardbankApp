//
//  DetailViewController.swift
//  standardbankApp
//
//  Created by Clive Ngobeni on 2020/10/29.
//

import UIKit
@IBDesignable
class DetailViewController: UIViewController {
    
    @IBOutlet var authDetailView: UILabel!
    
    var authMethod: viewModelApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = false
        authDetailView.text = "\((authMethod?.authName)!)"
    }
}
