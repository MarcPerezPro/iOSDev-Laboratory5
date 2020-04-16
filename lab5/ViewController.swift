//
//  ViewController.swift
//  lab5
//
//  Created by Marc PEREZ on 16/4/2020.
//  Copyright © 2020 Marc PEREZ. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate {

    @IBOutlet weak var webView: WKWebView!
    @IBAction func goBackButton(_ sender: UIButton) {
    }
    @IBAction func goForwardButton(_ sender: UIButton) {
    }
    @IBAction func goHomeButton(_ sender: UIButton) {
    }
    @IBOutlet weak var searchBar: UITextField!
    @IBAction func goToURLButton(_ sender: UIButton) {
    }
    @IBOutlet weak var contentSecureLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        let myURL = URL(string:"https://www.apple.com")
        let myRequest = URLRequest(url: myURL!)
        webView.load(myRequest)
    }


}

