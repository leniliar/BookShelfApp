import Foundation
import UIKit

final class PersonalInfoVC: UIViewController, EditPersonalInfoVCDelegate {
    
    func dataDidSave(model: ProfileModel) {
        if let name = model.name {
            nameLabel.text = name
        }
        if let email = model.email {
            emailLabel.text = email
        }
        if let age = model.age {
            ageLabel.text = age
        }
    }
    
    
    @IBOutlet weak var profilePic: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet weak var tapLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!
    @IBOutlet private weak var ageLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profilePic.layer.borderColor = CGColor(red: 0, green: 0, blue: 0, alpha: 1)
        profilePic.layer.cornerRadius = profilePic.frame.height / 2
        profilePic.layer.borderWidth = 1
        tapLabel.isHidden = false
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(addAProfilePPicDidTTap(_:)))
        tapGesture.numberOfTapsRequired = 1
        tapGesture.numberOfTouchesRequired = 1
        profilePic.isUserInteractionEnabled = true
        profilePic.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadInfo()
    }
    
 
    func loadInfo() {
        let request = Profile.fetchRequest()
        let profiles = try? CoreDataService.context.fetch(request)
        guard let profile = profiles?.last else {return}
      
        nameLabel.text = profile.name
        emailLabel.text = profile.email
        ageLabel.text = profile.age
}
    
    
    @IBAction private func saveDidTap() {
        guard let name = nameLabel.text, let email = emailLabel.text, let age = ageLabel.text else {return}
        guard let pictures = profilePic.image else {return}
        let context = CoreDataService.context
        context.perform {
            let personalDatas = Profile(context: context)
            personalDatas.name = name
            personalDatas.email = email
            personalDatas.age = age
            personalDatas.picture = pictures.pngData()
            CoreDataService.saveContext()
        }
    }
    
    @IBAction private func editProfileDidTap() {
        let editProfileVC = EditPersonalInfoVC(nibName: "\(EditPersonalInfoVC.self)", bundle: nil)
        editProfileVC.editDelegate = self
        editProfileVC.editModel = ProfileModel(name: nameLabel.text,
                                               email: emailLabel.text,
                                               age: ageLabel.text)
        present(editProfileVC, animated: true, completion: nil )
        
        
    }
    
    func imagePicker(sourceType: UIImagePickerController.SourceType) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = sourceType
        return imagePicker
    }
    

}
