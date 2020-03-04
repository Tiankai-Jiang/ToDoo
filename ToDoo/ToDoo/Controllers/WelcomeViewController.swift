import UIKit

class WelcomeViewController: UIViewController {
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setOutlook()
    }
    func setOutlook(){
        self.view.backgroundColor = .dark
        loginButton.backgroundColor = .light
        registerButton.backgroundColor = .light
        loginButton.layer.cornerRadius = loginButton.frame.size.height/2
        registerButton.layer.cornerRadius = registerButton.frame.size.height/2
    }
    @IBAction func pressLogin(_ sender: Any) {
        let vc=LoginViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.tintColor = UIColor.white
        
    }
    @IBAction func pressRegister(_ sender: Any) {
        let vc=RegisterViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        navigationController?.navigationBar.tintColor = UIColor.white
    }
}
