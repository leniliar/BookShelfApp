//
//  SearchScreenVC.swift
//  BookShelfApp
//
//  Created by user on 5.02.23.
//

import Foundation
import UIKit

final class SearchScreenVC: UIViewController {
    
    @IBOutlet private weak var bookTableView: UITableView!
    @IBOutlet private weak var searchBookBar: UISearchBar!
    
    var books:BooksModel? = nil
    private var networkService = NetworkServce()
    private var timer: Timer?
    override func viewDidLoad() {
        super.viewDidLoad()
        bookTableView.delegate = self
        bookTableView.dataSource = self
        searchBookBar.delegate = self
        
        let nib = UINib(nibName: "\(SearchScreenCell.self)", bundle: nil)
        bookTableView.register(nib, forCellReuseIdentifier: "\(SearchScreenCell.self)")
        
    }
    
}

extension SearchScreenVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return books?.docs.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "\(SearchScreenCell.self)", for: indexPath) as? SearchScreenCell
        let book = books?.docs[indexPath.row]
        cell?.titleLabel.text = book?.title
        cell?.authorNameLabel.text = book?.authorName?.first
        cell?.firstSentenceLabel.text = book?.firstSentence?.first ?? "There is no first sentence"
        cell?.pageLabel.text = String((book?.numberOfPagesMedian) ?? 0) + " " + "pages"
        cell?.yearLabel.text = String(book?.firstPublishYear ?? 0) + " " + "year"
        
        cell?.setImg(viewModel: book!)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let nextVC = BookInformattionSccreenVC(nibName: "\(BookInformattionSccreenVC.self)", bundle: nil)
        nextVC.book = books?.docs[indexPath.row]
        present(nextVC, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}

extension SearchScreenVC: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let search = searchText.split(separator: " ").joined(separator: "%20")
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { _ in
            
            
            self.networkService.loadBookInformation(title: search) { [weak self] book in
                self?.books = book ?? nil
                DispatchQueue.main.async {
                    self?.bookTableView.reloadData()
                }
                
            }
        })
       
    }
}
