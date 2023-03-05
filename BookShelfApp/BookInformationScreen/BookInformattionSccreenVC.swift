//
//  BookInformattionSccreenVC.swift
//  BookShelfApp
//
//  Created by user on 20.02.23.
//

import Foundation
import UIKit

final class BookInformattionSccreenVC: UIViewController {
    
    @IBOutlet private weak var bookImage: UIImageView!
    @IBOutlet private weak var bookName: UILabel!
    @IBOutlet private weak var authorName: UILabel!
    @IBOutlet private weak var firstSentenceLabel: UILabel!
    
    var networkService = NetworkServce()
    var book:Doc? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let book = book {
            bookName.text = book.title
            authorName.text = book.authorName?.first
            firstSentenceLabel.text = book.firstSentence?.first
            setImg(viewModel: book)
        }
        
        
        
    }
    
    func setImg(viewModel: Doc) {
        guard let coverID = viewModel.bookCover else { return }
        
        networkService.loadImgById(coverID: coverID) { img in
            let url = img?.url
            guard let image = URL(string: url ?? "") else {return}
            self.bookImage.sd_setImage(with: image, completed: nil)
        }
    }
    
    @IBAction private func addDidTapp() {
        
        let defaults = UserDefaults.standard
        if let savedData = try? NSKeyedArchiver.archivedData(withRootObject: Doc.self, requiringSecureCoding: false) {
            defaults.set(savedData, forKey: "Done")
        }
    }
    
    @IBAction private func closeDidTapp() {
        dismiss(animated: true, completion: nil)
    }
    
    
}

