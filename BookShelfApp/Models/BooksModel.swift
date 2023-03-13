import Foundation

struct BooksModel: Codable {
    let docs: [Doc]
    
    enum CodingKeys: String, CodingKey {
        case docs
    }
    init(from decoder: Decoder) throws {
        let contaner = try decoder.container(keyedBy: CodingKeys.self)
        docs.self = try contaner.decode([Doc].self, forKey: .docs)
    }
}

struct Doc: Codable {
    let title: String
    let numberOfPagesMedian: Int?
    let firstPublishYear: Int?
    let authorName: [String]?
    let firstSentence: [String]?
    let bookCover: Int?
    
    enum CodingKeys: String, CodingKey {
        case title
        case numberOfPagesMedian = "number_of_pages_median"
        case firstPublishYear = "first_publish_year"
        case authorName = "author_name"
        case firstSentence = "first_sentence"
        case bookCover = "cover_i"
    }
    
    init(from decoder: Decoder) throws {
        let contaner = try decoder.container(keyedBy: CodingKeys.self)
        title.self = try contaner.decode(String.self, forKey: .title)
        numberOfPagesMedian.self = try contaner.decodeIfPresent(Int.self, forKey: .numberOfPagesMedian)
        firstPublishYear.self = try contaner.decodeIfPresent(Int.self, forKey: .firstPublishYear)
        authorName.self = try contaner.decodeIfPresent([String].self, forKey: .authorName)
        firstSentence.self = try contaner.decodeIfPresent([String].self, forKey: .firstSentence)
        bookCover.self = try contaner.decodeIfPresent(Int.self, forKey:.bookCover)
    }
}

    

