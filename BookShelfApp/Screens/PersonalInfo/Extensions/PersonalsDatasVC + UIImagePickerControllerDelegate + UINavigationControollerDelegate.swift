import Foundation
import UIKit

extension PersonalInfoVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.profilePic.image = image
        self.tapLabel.isHidden = true
        self.dismiss(animated: true, completion: nil)
    }
    
}
