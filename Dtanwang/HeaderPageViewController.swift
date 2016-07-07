//
//  HeaderPageViewController.swift
//  Dtanwang
//
//  Created by liudong on 16/7/7.
//  Copyright © 2016年 lingjing. All rights reserved.
//

import UIKit

class HeaderPageViewController: UIViewController, UIWebViewDelegate {

    let urlString:String = "http://ac.qq.com/Comic/comicInfo/id/540148"
    
    @IBOutlet weak var spring: UIActivityIndicatorView!
    @IBOutlet weak var webView: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView.delegate = self
        
        self.spring.startAnimating()
        
        
        let url = NSURL(string: urlString)
        let request = NSURLRequest(URL: url!)
        self.webView.loadRequest(request)

        // Do any additional setup after loading the view.
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        self.spring.stopAnimating()
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
