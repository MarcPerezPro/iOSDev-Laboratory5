//
//  ViewController.swift
//  lab5
//
//  Created by Marc PEREZ on 16/4/2020.
//  Copyright © 2020 Marc PEREZ. All rights reserved.
//

import UIKit
import WebKit

class ViewController: UIViewController, WKUIDelegate, WKNavigationDelegate {
    
    let ALERT_EMPTY_URL = "You must provide some URL to go!"
    let ALERT_INVALID_URL = "You must provide a valid URL to go!"

    @IBOutlet weak var webView: WKWebView!
    @IBAction func goBackButton(_ sender: UIButton) {
        webView.goBack()
    }
    @IBAction func goForwardButton(_ sender: UIButton) {
        webView.goForward()
    }
    @IBAction func goHomeButton(_ sender: UIButton) {
        goHome()
    }
    @IBOutlet weak var searchBar: UITextField!
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "ERROR", message:
            message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        self.present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func goToURLButton(_ sender: UIButton) {
        var text = searchBar.text
        if (text == nil || text!.isEmpty) {
            showAlert(message: ALERT_EMPTY_URL)
            return
        }
        let https = "https://"
        if (!text!.starts(with: https)) {
            text = https + text!
        }
        goToURL(urlString: text)
    }
    @IBOutlet weak var contentSecureLabel: UILabel!
    
    func goToURL(url: URL) {
        let myRequest = URLRequest(url: url)
        webView.load(myRequest)
    }
    func goToURL(urlString: String?) {
        guard urlString != nil else {
            showAlert(message: ALERT_EMPTY_URL)
            return
        }
        let url = URL(string: urlString!)
        if (url == nil) {
            showAlert(message: ALERT_INVALID_URL)
            return
        }
        goToURL(url: url!)
    }

    func goHome() {
        goToURL(urlString: "https://www.google.com")
    }
    
    func printNavigator(_ webView: WKWebView) {
        let navigatorToJSON = """
        var _navigator = {};
        for (var i in navigator) _navigator[i] = navigator[i];
        JSON.stringify(_navigator);
        """
        
        webView.evaluateJavaScript(navigatorToJSON) { (result, error) in
            if error == nil {
                print("navigator =", result!)
            }
        }
    }
    
    func updateSecureContent(isSecure: Bool) {
        contentSecureLabel.text = "Secure content: "
        if (isSecure) {
            contentSecureLabel.text! += "YES"
        } else {
            contentSecureLabel.text! += "NO"
        }
    }
    
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        printNavigator(webView)
        updateSecureContent(isSecure: webView.hasOnlySecureContent)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        webView.uiDelegate = self
        webView.navigationDelegate = self
        goHome()
    }
}

