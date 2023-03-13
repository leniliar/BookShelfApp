import Foundation

struct Covers: Codable {
    var id: Int?
    var url: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case url = "source_url"
    }
    
    init(from decoder: Decoder) throws {
        let contaner = try decoder.container(keyedBy: CodingKeys.self)
        id.self = try contaner.decode(Int.self, forKey: .id)
        url.self = try contaner.decode(String.self, forKey:.url)
    }
}
