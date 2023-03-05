//
//  PersonalsDatasVC + UIImagePickerControllerDelegate + UINavigationControollerDelegate.swift
//  BookShelfApp
//
//  Created by user on 27.02.23.
//

import Foundation
import UIKit

extension PersonalsDatasVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.profilePic.image = image
        self.tapLabel.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
}
