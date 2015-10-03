//
//  WebDetailViewController.swift
//  WeatherApp
//
//  Created by Zoufishan Mehdi on 10/2/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//

import UIKit


class WebDetailViewController: UIViewController {

    @IBOutlet weak var webView: UIWebView!
    
    var toWeb:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

     
         var url = NSURL(string: "http://www.weather-forecast.com/locations/" + toWeb + "/forecasts/latest")
        
        var request = NSURLRequest(URL: url!)
        
        webView.loadRequest(request)
        

        
        let html = "<html><body><h1>My Page</h1><p>This is my web page.</p></body></html>"
        
        webView.loadHTMLString(html, baseURL: nil)
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
