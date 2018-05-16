//
//  FileSystemManager.swift
//  CoreDataNewTry
//
//  Created by Tianyuan Zhang on 2018/5/12.
//  Copyright © 2018年 qwe. All rights reserved.
//

import Foundation
import UIKit

class FileSystemManager{
    
    static let fileSystemManager = FileSystemManager()
    lazy var fileManager = FileManager.default
    let filePath: String = NSHomeDirectory() + "/Documents/"
    
    func checkFolderExistence(type: String) -> (Bool){
        let path = filePath + type
        let exist = fileManager.fileExists(atPath: path)
        return exist
    }
    
    func createFolder(type: String){
        if !checkFolderExistence(type: type) {
            do {
                try fileManager.createDirectory(atPath: filePath + type, withIntermediateDirectories: true, attributes: nil)
                print("\(type) folder is created!")
                return
            }
            catch let error as NSError{
                NSLog("Creation failed: \(error.debugDescription)")
            }
        }
        print("\(type) folder is detected!")
    }
    
    func createImageFolder(){
        createFolder(type: "Images")
    }
    
    func createVideoFolder(){
        createFolder(type: "Videos")
    }
    
    func createAudioFolder(){
        createFolder(type: "Audios")
    }
    
    func saveImage(person: Person, image: UIImage, quality: CGFloat, nameWithExtension: String){
        if let imageRep = UIImageJPEGRepresentation(image, quality) as NSData?{
            let imageURLString = filePath + "Images/\(nameWithExtension)"
            imageRep.write(toFile: imageURLString, atomically: true)
            person.photo = "Images/\(nameWithExtension)"
            print("Image is saved!")
            print(imageURLString)
        }
    }
    
    func getImage(person: Person) -> (UIImage){
        print("Image url: ")
        print(person.photo!)
        let image = UIImage(contentsOfFile: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String + "/" + person.photo!)
        return image!
    }
    
    func deletImage(URLString: String){
        do{
            try fileManager.removeItem(atPath: URLString)
            print("Image is removed!")
        }
        catch let error as NSError{
            print("error")
            print(error.localizedDescription)
            fatalError(NSError.debugDescription())
        }
    }
    
    func saveVideo(person: Person, videoFromURLString: String, nameWithExtension: String){
        if let urlData = NSData(contentsOfFile: videoFromURLString){
            let videoURLString = filePath + "Videos/\(nameWithExtension)"
            urlData.write(toFile: videoURLString, atomically: true)
            person.video = "Videos/\(nameWithExtension)"
            print("Video is saved!")
        }
    }
    
    func getVideo(person: Person) -> (URL){
        return URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String + "/Videos/\(person.video!)")!
    }
    
    func saveAudio(person: Person, audioFromURLString: String, nameWithExtension: String){
        if let urlData = NSData(contentsOfFile: audioFromURLString){
            let audioURLString = filePath + "Audios/\(nameWithExtension)"
            urlData.write(toFile: audioURLString, atomically: true)
            person.audio = "Audios/\(nameWithExtension)"
            print("Audio is saved!")
        }
    }
    
    func getAudio(person: Person) -> (URL){
        return URL(string: NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String + "/Audios/\(person.audio!)")!
    }
}
