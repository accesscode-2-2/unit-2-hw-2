//
//  MapWebViewController.swift
//  WeatherApp
//
//  Created by Zoufishan Mehdi on 9/30/15.
//  Copyright © 2015 Zoufishan Mehdi. All rights reserved.
//

import UIKit
import MapKit

class MapWebViewController: UIViewController {
    
    var annotation:MKAnnotation!
    var pointAnnotation:MKPointAnnotation!
    var pinAnnotationView:MKPinAnnotationView!
    
    var localSearchRequest:MKLocalSearchRequest!
    var localSearch:MKLocalSearch!
    var localSearchResponse:MKLocalSearchResponse!

    @IBOutlet weak var weatherMap: MKMapView!
    @IBOutlet weak var weatherLabel: UILabel!
    
    var toPass:String!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
    
    
    func showError() {
        
        weatherLabel.text = "Was not able to find weather for " + (toPass as String) + ". Please try again"
        
    }
    
    
    func webView () {
        
        var url = NSURL(string: "http://www.weather-forecast.com/locations/" + toPass.stringByReplacingOccurrencesOfString(" ", withString: "-") + "/forecasts/latest")
        
        if url != nil {
            
            let task = NSURLSession.sharedSession().dataTaskWithURL(url!, completionHandler: { (data, response, error) -> Void in
                
                var urlError = false
                
                var weather = ""
                
                if error == nil {
                    
                    var urlContent = NSString(data: data!, encoding: NSUTF8StringEncoding) as NSString!
                    
                    var urlContentArray = urlContent.componentsSeparatedByString("<span class=\"phrase\">")
                    
                    if urlContentArray.count > 0 {
                        
                        var weatherArray = urlContentArray[1].componentsSeparatedByString("</span>")
                        
                        weather = weatherArray[0]
                        
                        weather = weather.stringByReplacingOccurrencesOfString("&deg;", withString: "º")
                        
                    } else {
                        
                        urlError = true
                        
                    }
                    
                    
                    
                } else {
                    
                    urlError = true
                    
                }
                
                dispatch_async(dispatch_get_main_queue()) {
                    
                    if urlError == true {
                        
                        self.showError()
                        
                    } else {
                        
                        self.weatherLabel.text = weather
                        
                    }
                }
                
            })
            
            task.resume()
            
            
        } else {
            
            showError()
            
        }
        
        
    }
    

    
    
    func textfieldClicked(userCity: UITextField){
        //            //1
        //           // textfield.resignFirstResponder()
        //            dismissViewControllerAnimated(true, completion: nil)
        if self.weatherMap.annotations.count != 0{
            annotation = self.weatherMap.annotations[0]
            self.weatherMap.removeAnnotation(annotation)
        }
        //            //2
        //            localSearchRequest = MKLocalSearchRequest()
        //            localSearchRequest.naturalLanguageQuery = toPass
        //            localSearch = MKLocalSearch(request: localSearchRequest)
        //            localSearch.startWithCompletionHandler { (localSearchResponse, error) -> Void in
        //
        //                if localSearchResponse == nil{
        //                    let alert = UIAlertView(title: nil, message: "Place not found", delegate: self, cancelButtonTitle: "Try again")
        //                    alert.show()
        //                    return
        //                }
        //3
        self.pointAnnotation = MKPointAnnotation()
        self.pointAnnotation.title = self.toPass
        self.pointAnnotation.coordinate = CLLocationCoordinate2D(latitude: localSearchResponse!.boundingRegion.center.latitude, longitude:     localSearchResponse!.boundingRegion.center.longitude)
        
        
        self.pinAnnotationView = MKPinAnnotationView(annotation: self.pointAnnotation, reuseIdentifier: nil)
        self.weatherMap.centerCoordinate = self.pointAnnotation.coordinate
        self.weatherMap.addAnnotation(self.pinAnnotationView.annotation!)
    }
    
    
    
    
    
    
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject!) {
        
        if segue.identifier == "webSegue" {
            
            let tvc = segue.destinationViewController as! WebDetailViewController;
            
            tvc.toWeb = toPass
        }
        
    }
    
}







