//
//  ViewController.swift
//  TesseractDemo
//
//  Created by Z on 9/29/15.
//  Copyright © 2015 dereknetto. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController, UITextViewDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var textLabel: UILabel!
    var activityIndicator:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func takePhoto(sender: AnyObject) {
        // 2
        let imagePickerActionSheet = UIAlertController(title: "Snap/Upload Photo",
            message: nil, preferredStyle: .ActionSheet)
        
        // 3
        if UIImagePickerController.isSourceTypeAvailable(.Camera) {
            let cameraButton = UIAlertAction(title: "Take Photo",
                style: .Default) { (alert) -> Void in
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .Camera
                    self.presentViewController(imagePicker,
                        animated: true,
                        completion: nil)
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        // 4
        let libraryButton = UIAlertAction(title: "Choose Existing",
            style: .Default) { (alert) -> Void in
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .PhotoLibrary
                self.presentViewController(imagePicker,
                    animated: true,
                    completion: nil)
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        // 5
        let cancelButton = UIAlertAction(title: "Cancel",
            style: .Cancel) { (alert) -> Void in
        }
        imagePickerActionSheet.addAction(cancelButton)
        
        // 6
        presentViewController(imagePickerActionSheet, animated: true,
            completion: nil)
    }
    
    func scaleImage(image: UIImage, maxDimension: CGFloat) -> UIImage {
        
        var scaledSize = CGSizeMake(maxDimension, maxDimension)
        var scaleFactor:CGFloat
        
        if image.size.width > image.size.height {
            scaleFactor = image.size.height / image.size.width
            scaledSize.width = maxDimension
            scaledSize.height = scaledSize.width * scaleFactor
        } else {
            scaleFactor = image.size.width / image.size.height
            scaledSize.height = maxDimension
            scaledSize.width = scaledSize.height * scaleFactor
        }
        
        UIGraphicsBeginImageContext(scaledSize)
        image.drawInRect(CGRectMake(0, 0, scaledSize.width, scaledSize.height))
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return scaledImage
    }
    
    // Activity Indicator methods
    
    func addActivityIndicator() {
        activityIndicator = UIActivityIndicatorView(frame: view.bounds)
        activityIndicator.activityIndicatorViewStyle = .WhiteLarge
        activityIndicator.backgroundColor = UIColor(white: 0, alpha: 0.25)
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }
    
    func removeActivityIndicator() {
        activityIndicator.removeFromSuperview()
        activityIndicator = nil
    }
    
    func performTesseractImageRecognition(image: UIImage) {
        // 1
        let tesseract = G8Tesseract()
        
        // 2
        tesseract.language = "eng+fra"
        
        // 3
        tesseract.engineMode = .TesseractOnly
        
        // 4
        tesseract.pageSegmentationMode = .Auto
        
        // 5
        tesseract.maximumRecognitionTime = 60.0
        
        // 6
        tesseract.image = image.g8_blackAndWhite()
        tesseract.recognize()
        
        // 7
        textLabel.text = tesseract.recognizedText
        
        // 8
        removeActivityIndicator()
    }
}

extension ViewController: UIImagePickerControllerDelegate {
    
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject]) {
            let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
            let scaledImage = scaleImage(selectedPhoto, maxDimension: 640)
            
            addActivityIndicator()
            
            dismissViewControllerAnimated(true, completion: {
                self.performTesseractImageRecognition(scaledImage)
            })
    }
}


