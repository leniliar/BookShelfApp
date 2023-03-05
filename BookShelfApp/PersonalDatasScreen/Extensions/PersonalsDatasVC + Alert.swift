//
//  PersonalsDatasVC + Alert.swift
//  BookShelfApp
//
//  Created by user on 27.02.23.
//

import Foundation
import UIKit

extension PersonalsDatasVC {
    
    @objc func addAProfilePPicDidTTap( _ gesture: UITapGestureRecognizer) {
        guard gesture.view != nil else {return}
        
        let alert = UIAlertController(title: "Add a profile photo", message: nil, preferredStyle: .actionSheet)
        
        let openGalleryAction = UIAlertAction(title: "Open Gallery ", style: .default) { [weak self] _ in
            guard let self = self else { return }
            let galleryPhoto = self.imagePicker(sourceType: .photoLibrary)
            galleryPhoto.delegate = self
            self.present(galleryPhoto, animated: true, completion: nil)
        }
        alert.addAction(openGalleryAction)
        
        let openCameraActon = UIAlertAction(title: "Open camera", style: .default) { [weak self] _  in
            guard let self = self else { return }
            let camera = self.imagePicker(sourceType: .camera)
            camera.delegate = self
            self.present(camera, animated: true, completion: nil)
        }
        alert.addAction(openCameraActon)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
}
