//
//  HelloWorldViewController.swift
//  Weather
//
//  Created by Ольга on 19.01.2023.
//

import UIKit

class HelloWorldViewController: UIViewController {
    
    @IBOutlet private var centerText: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func addWord(_ sender: UIBarButtonItem) {
        centerText.text = (centerText.text ?? "") + " hello"
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print(#function)
    }

    

}
