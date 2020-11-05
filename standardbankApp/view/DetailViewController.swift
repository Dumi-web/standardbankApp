//
//  DetailViewController.swift
//  standardbankApp
//
//  Created by Clive Ngobeni on 2020/10/29.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet var authDetailView: UILabel!
    
    @IBOutlet var navBar: UINavigationItem!
    var authMethod: viewModelApp?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        authDetailView.text = "\((authMethod?.authName)!)"
    }
}
