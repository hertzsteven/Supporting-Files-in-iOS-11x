//
//  ViewController.swift
//  UsingFiles
//
//  Created by Tim Richardson on 10/05/2018.
//  Copyright © 2018 iOS Mastery. All rights reserved.
//

import UIKit
import MobileCoreServices
import CloudKit


class ViewController: UIViewController {

    var dbs : CKDatabase {
          return CKContainer(identifier: "iCloud.com.dia.cloudKitExample.open").publicCloudDatabase
      }

    var picFileUrl: URL?
    
    @IBOutlet weak var picView: UIImageView!
    
    @IBAction func writeFiles(_ sender: Any) {
        addRecord()
        return
        
        let file = "\(UUID().uuidString).txt"
        let contents = "Some text..."
        
        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
        let fileURL = dir.appendingPathComponent(file)
        
        do {
            try contents.write(to: fileURL, atomically: false, encoding: .utf8)
        }
        catch {
            print("Error: \(error)")
        }
    }
    
    @IBAction func importFiles(_ sender: Any) {
        
        let documentPicker = UIDocumentPickerViewController(documentTypes: [kUTTypePlainText as String, kUTTypeJPEG as String], in: .import)
        documentPicker.delegate = self
        documentPicker.allowsMultipleSelection = true
        present(documentPicker, animated: true, completion: nil)
    }
    
    fileprivate func addRecord() {
        // Do any additional setup after loading the view.
        
        // make a ckrecord
        let record = CKRecord(recordType: "iPad")
        record["currentUser"] = NSString("iiiiii")
        record["identifier"] =  NSString("iiiiii")
        record["userLevel"] =   NSString("iiiiii")
        
        dbs.save(record) { (record, error) in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            print("added succesfully")
            print(record as Any)
        }
    }

    
}

extension ViewController: UIDocumentPickerDelegate {
    
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        
        urls.forEach {
            print($0.deletingPathExtension().lastPathComponent)
        }
        
        
//        guard let selectedFileURL = urls.first else {
//            return
//        }
//        
//        let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
//        let sandboxFileURL = dir.appendingPathComponent(selectedFileURL.lastPathComponent)
//        
//        if FileManager.default.fileExists(atPath: sandboxFileURL.path) {
//            print("Already exists! Do nothing")
//        }
//        else {
//            
//            do {
//                try FileManager.default.copyItem(at: selectedFileURL, to: sandboxFileURL)
//                picFileUrl = sandboxFileURL
//                print("Copied file!")
//            }
//            catch {
//                print("Error: \(error)")
//            }
//        }
//        print("about to do the pic")
//        picView.image = UIImage(contentsOfFile: picFileUrl!.path)
//        print("did it")
       
    }
}




























