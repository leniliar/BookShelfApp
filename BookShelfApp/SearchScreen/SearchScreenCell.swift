//
//  SearchScreenCell.swift
//  BookShelfApp
//
//  Created by user on 6.02.23.
//

import UIKit
import SDWebImage

 final class SearchScreenCell: UITableViewCell {
     
    let book:BooksModel? = nil
    private var networkService = NetworkServce()
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorNameLabel: UILabel!
    @IBOutlet weak var pageLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var firstSentenceLabel: UILabel!
     
    
     
     override func prepareForReuse() {
         super.prepareForReuse()
         bookImage.image = nil
        }
     
     
    
     func setImg(viewModel: Doc) {
         guard let coverID = viewModel.bookCover else { return }
         
         networkService.loadImgById(coverID: coverID) { img in
             let url = img?.url
             guard let image = URL(string: url ?? "") else {return}
             self.bookImage.sd_setImage(with: image, completed: nil)
         }
        
     }
}
