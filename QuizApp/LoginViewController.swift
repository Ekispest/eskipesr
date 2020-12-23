import UIKit

import FirebaseAuth
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        errorLabel.alpha = 0
        // Do any additional setup after loading the view.
    }
    
    func checkAreFieldsValid() -> String? {
           if emailTextField.text == "" || passwordTextField.text == "" || emailTextField.text == nil || passwordTextField.text == nil {
               return "Fill in all fields"
           }
           return nil
    }
    @IBAction func loginButtonPressed(_ sender: Any) {
        let result = checkAreFieldsValid()
        if result != nil {
            errorLabel.alpha = 1
            errorLabel.numberOfLines = 0
            errorLabel.textColor = .red
            errorLabel.lineBreakMode = .byWordWrapping
            errorLabel.text = result
            errorLabel.sizeToFit()
        }
        else {
         self.errorLabel.alpha = 0
         Auth.auth().signIn(withEmail: emailTextField.text!, password: passwordTextField.text!) {
                (result, error) in
                if error != nil {
                     self.errorLabel.alpha = 1
                     self.errorLabel.numberOfLines = 0
                     self.errorLabel.textColor = .red
                     self.errorLabel.lineBreakMode = .byWordWrapping
                     self.errorLabel.text = error?.localizedDescription
                     self.errorLabel.sizeToFit()
                }
                else {
                 let storyboard = UIStoryboard(name: "Main", bundle: nil)
                 let secondVC = storyboard.instantiateViewController(identifier: "ViewController") as! ViewController
                 self.view.window?.rootViewController = secondVC
             }
            }
        
    }
    
}
}
