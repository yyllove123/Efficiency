//
//  MovieDetailViewController.swift
//  Efficiency
//
//  Created by Yalin on 16/4/16.
//  Copyright © 2016年 Yalin. All rights reserved.
//

import UIKit
import MediaPlayer
import AVKit

class MovieDetailViewController: UIViewController {
    
    var moviePath: String = ""
    @IBOutlet weak var webView: UIWebView!
    
    convenience init(moviePath: String) {
        self.init(nibName: "MovieDetailViewController", bundle: nil)
        self.moviePath = moviePath
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        webView.scalesPageToFit = true
        webView.loadRequest(URLRequest(url: URL(fileURLWithPath: moviePath) as URL))
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

}
