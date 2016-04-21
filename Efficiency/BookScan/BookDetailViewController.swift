//
//  BookDetailViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/4/16.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit

class BookDetailViewController: UIViewController, UIWebViewDelegate {

    var bookPath: String = ""
    @IBOutlet weak var webView: UIWebView!
    
    convenience init(bookPath: String) {
        self.init(nibName: "BookDetailViewController", bundle: nil)
        self.bookPath = bookPath
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.scalesPageToFit = true
        webView.loadRequest(NSURLRequest(URL: NSURL(fileURLWithPath: bookPath)))
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: - UIWebView Delegate
    func webViewDidFinishLoad(webView: UIWebView) {
//        webView.stringByEvaluatingJavaScriptFromString("document.body.style.zoom=0.5");
    }
}
