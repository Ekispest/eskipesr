import UIKit
import FirebaseAuth
import Firebase

class SignUpViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var signUpButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
       
    func checkValidFields() -> String? {
        if nameTextField.text == "" || nameTextField.text == nil ||
            emailTextField.text == "" || emailTextField.text == nil ||
            passwordTextField.text == "" || passwordTextField.text == nil {
            return "Fill in all fields"
        }
        return nil
    }
    
    @IBAction func signUpButtonPressed(_ sender: Any) {
        let result = checkValidFields()
        if result != nil {
            errorLabel.alpha = 1
            errorLabel.numberOfLines = 0
            errorLabel.textColor = .red
            errorLabel.lineBreakMode = .byWordWrapping
            errorLabel.text = result
            errorLabel.sizeToFit()
        }
        else {
            Auth.auth().createUser(withEmail: emailTextField.text!, password: passwordTextField.text!)
            {
                (result, error) in
                if error != nil {
                    self.errorLabel.text = error?.localizedDescription
                }
                else {
                    self.errorLabel.alpha = 0
                    let db = Firestore.firestore()
                    db.collection("users").addDocument(data: [
                        "email": self.emailTextField.text!,
                        "name": self.nameTextField.text!,
                        "password": self.passwordTextField.text!
                    ]) { (error) in
                        if error != nil {
                            self.errorLabel.alpha = 1
                            self.errorLabel.textColor = .red
                            self.errorLabel.text = "Saving user error"
                        }
                        else {
                            let storyboard = UIStoryboard(name: "Main", bundle: nil)
                            let secondVC = storyboard.instantiateViewController(identifier: "AuthViewController") as! AuthViewController
                            self.navigationController?.pushViewController(secondVC, animated: true)
                        }
                    }
                }
            }
        }
    }
    

}
