//
//  ImageSaver.swift
//  InstaFilter
//
//  Created by Mahmoud Fouad on 8/14/21.
//

import SwiftUI

class ImageSaver: NSObject {
    
    var successHandler: (() -> Void)?
    var erorrHandler: ((Error) -> Void)?
    
    
    func writeToPhotoAlbum(image: UIImage) {
        UIImageWriteToSavedPhotosAlbum(image, self, #selector(self.saveError(_:didFinishSavingWithError:contextInfo:)), nil)
    }
    
    @objc func saveError(_ image: UIImage, didFinishSavingWithError error: Error?, contextInfo: UnsafeRawPointer) {
        if let error = error {
            erorrHandler?(error)
        } else {
            successHandler?()
        }
        
    }
}
