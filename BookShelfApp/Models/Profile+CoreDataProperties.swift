import Foundation
import CoreData


extension Profile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Profile> {
        return NSFetchRequest<Profile>(entityName: "Profile")
    }

    @NSManaged public var age: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var picture: Data?

}

extension Profile : Identifiable {

}
