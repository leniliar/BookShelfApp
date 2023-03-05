//
//  NetworkServce.swift
//  BookShelfApp
//
//  Created by user on 6.02.23.
//

import Foundation

final class NetworkServce {
    
    func loadBookInformation(title: String, completion: @escaping (BooksModel?) -> Void) {
        guard let url = URL(string: "https://openlibrary.org/search.json?title=\(title)") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
         URLSession.shared.dataTask(with: request) { data, response, error
             in
             guard let data = data else { return }
             
             do {
                 let bookList = try JSONDecoder().decode(BooksModel.self, from: data)
                 completion(bookList)
                 
             } catch let jsonError {
                 print("Error", jsonError)
             }
        }.resume()}
    
    func loadImgById(coverID: Int, completion: @escaping (Covers?) -> Void) {
        
        guard let url = URL(string: "https://covers.openlibrary.org/b/id/\(coverID).json") else {return}
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data = data else {return}
            
            do{
                let bookCover = try JSONDecoder().decode(Covers.self, from: data)
                completion(bookCover)
                
            } catch let jsonError {
                print(jsonError)
                
            }

        }.resume()
        
    }
}

