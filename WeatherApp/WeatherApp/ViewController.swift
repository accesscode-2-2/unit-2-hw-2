//
//  ViewController.swift
//  WeatherApp
//
//  Created by Zoufishan Mehdi on 9/30/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//

import UIKit
import MapKit

//var city:NSString = ""


class ViewController: UIViewController, UITextFieldDelegate, UITableViewDelegate {

    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!
    
    @IBOutlet weak var userCity: UITextField!
    @IBOutlet weak var luckyButton: UIButton!
    @IBOutlet weak var luckyButtonTapped: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        func search () {
                    userCity.resignFirstResponder()
                    dismissViewControllerAnimated(true, completion: nil)
     
                    //2
                    localSearchRequest = MKLocalSearchRequest()
                    localSearchRequest.naturalLanguageQuery = userCity.text
                    localSearch = MKLocalSearch(request: localSearchRequest)
                    localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
        
                        if localSearchResponse == nil{
                            let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
                            alert.show()
                            return
                        }
        
        // Do any additional setup after loading the view, typically from a nib.
    }
        }

    
    func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "segueTest" {
            
            var svc = segue.destinationViewController as! MapWebViewController;
            
            svc.toPass = userCity.text!
        }
    
   //city = enterCity.text.stringByReplacingOccurrencesOfString(" ", withString: "-")
}
    
}
 

//how to pass variable in swift- prepare for segue
}