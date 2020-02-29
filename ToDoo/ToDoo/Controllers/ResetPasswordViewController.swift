import UIKit
import Firebase
import Toast_Swift

class ResetPasswordViewController: UIViewController {

    @IBOutlet weak var resetPasswordEmailTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func passwordResetDidTapped(_ sender: UIButton) {
        let email = resetPasswordEmailTextField.text!
        Auth.auth().sendPasswordReset(withEmail: email) { (error) in
            if let e = error{
                self.view.makeToast(e.localizedDescription, duration: 2.5, position: .center)
            }else{
                self.view.makeToast("Reset Email sent successfully, please check your inbox and follow the instructionto reset your password", duration: 2.0, position: .center)
            }
        }
    }
}
