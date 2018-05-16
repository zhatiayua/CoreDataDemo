//
//  ViewController.swift
//  coreDataAndFileSystem
//
//  Created by Tianyuan Zhang on 2018/5/15.
//  Copyright © 2018年 Tianyuan Zhang. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let coreDataManager: CoreDataManager = CoreDataManager.coreDataManager

    override func viewDidLoad() {
        super.viewDidLoad()
        coreDataManager.fileSystemManager.createImageFolder()
        coreDataManager.fileSystemManager.createVideoFolder()
        coreDataManager.fileSystemManager.createAudioFolder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBOutlet weak var nameText: UITextField!
    
    @IBOutlet weak var ageText: UITextField!
    
    @IBAction func saveButton(_ sender: Any) {
        coreDataManager.saveData(name: nameText.text!, age: ageText.text!)
        nameText.text = ""
        ageText.text = ""
    }
    
    @IBAction func readButton(_ sender: Any) {
        let person: Person = coreDataManager.retrieveData(name: nameText.text!)
        ageText.text = person.age
        imageView.image = coreDataManager.fileSystemManager.getImage(person: person)
        
    }
    
    @IBAction func deletAllButton(_ sender: Any) {
        imageView.image = nil
        coreDataManager.deleteAllPerson()
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
}

