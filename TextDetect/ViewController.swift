//
//  ViewController.swift
//  TextDetect
//
//  Created by Sayalee on 6/13/18.
//  Copyright © 2018 Assignment. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class ViewController: UIViewController, UINavigationControllerDelegate {
    var detectedtext = ""
    
    @IBAction func Warning(_ sender: Any) {
        performSegue(withIdentifier:"mySegue3", sender: self)
    }
    
    
    @IBAction func Export(_ sender: Any) {
        let fileName = "ingredients.csv"
        let path = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(fileName)
        var csvText = detectedtext
        do {
            try csvText.write(to: path!, atomically: true, encoding: String.Encoding.utf8)
            let vc = UIActivityViewController(activityItems: [path], applicationActivities: [])
            present(vc, animated: true, completion: nil)
            vc.excludedActivityTypes = [
                UIActivityType.assignToContact,
                UIActivityType.saveToCameraRoll,
                UIActivityType.postToFlickr,
                UIActivityType.postToVimeo,
                UIActivityType.postToTencentWeibo,
                UIActivityType.postToTwitter,
                UIActivityType.postToFacebook,
                UIActivityType.openInIBooks
            ]
        } catch {
            print("Failed to create file")
            print("\(error)")
        }
        
    }
    
    @IBAction func history(_ sender: Any) {
        performSegue(withIdentifier: "mySegue2", sender: self)
    }
    var ref: DatabaseReference?
    @IBOutlet weak var output: UILabel!
    @IBOutlet weak var detectedText: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    lazy var vision = Vision.vision()
    var textDetector: VisionTextDetector?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // setBackground()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
}

// MARK: - UIImagePickerControllerDelegate

extension ViewController: UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else {
            fatalError("couldn't load image")
        }
        imageView.image = image
        
        detectText(image: image)
    }
}

// MARK: - IBActions

extension ViewController {
    
    
    @IBAction func cameraButtonTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.camera)  else {
            let alert = UIAlertController(title: "No camera", message: "This device does not support camera.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .camera
        picker.cameraCaptureMode = .photo
        self.present(picker, animated: true, completion: nil)
    }
    
    @IBAction func photosButtonTapped(_ sender: Any) {
        guard UIImagePickerController.isSourceTypeAvailable(.photoLibrary)  else {
            let alert = UIAlertController(title: "No photos", message: "This device does not support photos.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .cancel, handler: nil)
            alert.addAction(ok)
            self.present(alert, animated: true, completion: nil)
            return
        }
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        self.present(picker, animated: true, completion: nil)
    }
}

// MARK: - Methods

extension ViewController {
    func detectText (image: UIImage) {
        
        textDetector = vision.textDetector()
        
        let visionImage = VisionImage(image: image)
        
        textDetector?.detect(in: visionImage) { (features, error) in
            guard error == nil, let features = features, !features.isEmpty else {
                return
            }
            
            debugPrint("Feature blocks in th image: \(features.count)")
            
            self.detectedtext = ""
            for feature in features {
                let value = feature.text
                self.detectedtext.append("\(value) ")
//                print(detectedText)
            }
            
            //////YUH
            debugPrint(self.detectedtext)
            self.detectedText.text = self.detectedtext
            
//            if self.ref != nil{
//                self.ref?.child("list").childByAutoId().setValue(detectedText)
//                //detectedText = ""
//            }
            
//            // Save data to file
//            let fileName = "Test"
//            let DocumentDirURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
//
//            let fileURL = DocumentDirURL.appendingPathComponent(fileName).appendingPathExtension("txt")
//            print("FilePath: \(fileURL.path)")
//
//            let writeString = "Write this text to the fileURL as text in iOS using Swift"
//            do {
//                // Write to the file
//                try writeString.write(to: fileURL, atomically: true, encoding: String.Encoding.utf8)
//            } catch let error as NSError {
//                print("Failed writing to URL: \(fileURL), Error: " + error.localizedDescription)
//            }
//
//            var readString = "" // Used to store the file contents
//            do {
//                // Read the file contents
//                readString = try String(contentsOf: fileURL)
//            } catch let error as NSError {
//                print("Failed reading from URL: \(fileURL), Error: " + error.localizedDescription)
//            }
//            print("File Text: \(readString)")
//
        }
    }
}


