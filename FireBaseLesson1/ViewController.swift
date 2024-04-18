import UIKit
import SnapKit

class ViewController: UIViewController {
    
    let firebaseManager = FirebaseManager.shared
    
    var users = [UserResponse]()
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.addTarget(self, action: #selector(addUser), for: .touchUpInside)
        return button
    }()
    
    lazy var textField: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "insert new name"
        textfield.borderStyle = .roundedRect
        textfield.delegate = self
        return textfield
    }()
    
    @objc func addUser() {
//        firebaseManager.createUser()
//        firebaseManager.getUsers { users in
//            print(users)
//            self.users = users
//        }
        firebaseManager.deleteUser(users[0])
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        firebaseManager.getUsers { users in
            print(users)
            self.users = users
        }
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(textField)

        
        button.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(button.snp.bottom).offset(8)
            make.leading.trailing.equalToSuperview().inset(12)
        }
    }
}


extension ViewController: UITextFieldDelegate {
//    func textFieldDidEndEditing(_ textField: UITextField, reason: UITextField.DidEndEditingReason) {
//        
//    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        var user = users[0]
        print(user)
        user.lastName = textField.text!
        firebaseManager.updateUser(user)
        return true
    }
}
