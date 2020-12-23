import UIKit
import FirebaseAuth

class SettingsViewController: UIViewController {

    @IBOutlet weak var themeSwitch: UISwitch!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        themeSwitch.isOn = UserDefaults.standard.bool(forKey: "isLightTheme")
    }
    
    @IBAction func logoutButtonPressed(_ sender: Any) {
        let firebaseAuth = Auth.auth()
        do {
          try firebaseAuth.signOut()
        } catch let error as NSError {
          print (error)
        }
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyboard.instantiateViewController(identifier: "AuthViewController") as! AuthViewController
        self.view.window?.rootViewController = secondVC
    }
    
    @IBAction func themeSwitchTriggered(_ sender: UISwitch) {
        let isLightTheme = sender.isOn
        UserDefaults.standard.set(isLightTheme, forKey: "isLightTheme")
        let theme: UIUserInterfaceStyle = isLightTheme ? .light : .dark
        (view.window?.windowScene?.delegate as? SceneDelegate)?.changeTheme(to: theme)
    }
    
}
