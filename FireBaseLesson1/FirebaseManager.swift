import Foundation
import FirebaseCore
import FirebaseFirestore

class FirebaseManager {
    
    static let shared = FirebaseManager()
    
    var db: Firestore!
    
    
    func createUser() {
        db = Firestore.firestore()
        do {
            let ref = try db.collection("users").addDocument(data: [
                "firstName": "Aldiyar",
                "lastName": "Aitpayev",
                "born": 2002
            ])
            print("Document added with ID: \(ref.documentID)")
        } catch {
            print("Error adding document: \(error)")
        }
    }
    
    func getUsers(completion: @escaping ([UserResponse]) -> Void) {
        db = Firestore.firestore()
        
        
        db.collection("users").getDocuments { snapshot, error in
            if let error = error  {
                print(error)
                return
            }
            guard let documents = snapshot?.documents else {
                print("Error while getting documents")
                return }
            var users = [UserResponse]()
            for document in documents {
                let user = try! document.data(as: User.self)
                
                let response = UserResponse(user: user, id: document.documentID)
                
                users.append(response)
            }
            completion(users)
        }
    }
    
    func updateUser(_ newUser: UserResponse) {
        db = Firestore.firestore()
        
        db.collection("users").document(newUser.id).setData(["lastName": newUser.lastName], merge: true)
    }
    
    func deleteUser(_ newUser: UserResponse) {
        db = Firestore.firestore()

        db.collection("users").document(newUser.id).delete()
    }
    
    
}


