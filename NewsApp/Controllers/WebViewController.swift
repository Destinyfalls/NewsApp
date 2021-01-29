//
//  WebViewController.swift
//  NewsApp
//
//  Created by Igor Belobrov on 29.01.2021.
//

import UIKit
import WebKit

class WebViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    var articleUrl: URL?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUrlIfNeeded()
    }
    
    private func loadUrlIfNeeded() {
        guard let url = articleUrl else { return }
        webView.load(URLRequest(url: url))
    }
}
