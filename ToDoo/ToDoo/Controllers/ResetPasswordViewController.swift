import UIKit
import Firebase
import Toast_Swift

class ResetPasswordViewController: UIViewController, UITextFieldDelegate {

    private let loginFrame = CGRect(x: 0, y: 0, width: 160, height: 22)
    private let textFieldHeight: CGFloat = 37
    private let textFieldHorizontalMargin: CGFloat = 16.5
    private let textFieldSpacing: CGFloat = 22
    private let textFieldTopMargin: CGFloat = 38.8
    private let textFieldWidth: CGFloat = 206
    private lazy var resetPasswordEmailTextField: UITextField = {
        let textField = createTextField(text: "Email")
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        return textField
    }()
    
    private lazy var resetButton:UIButton = {
        let button = UIButton(type:.custom)
        button.backgroundColor = .light
        button.tintColor = .dark
        button.frame = loginFrame
        button.setTitle("Reset Password", for: .normal)
        button.setTitleColor(.text, for: .normal)
        button.layer.cornerRadius = textFieldHeight/2
        button.addTarget(self, action: #selector(resetPress(_:)), for: .touchUpInside)
        return button
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    private func setUpView() {
        view.backgroundColor = .dark
        view.addSubview(resetPasswordEmailTextField)
        setUpEmailTextFieldConstraints()

        view.addSubview(resetButton)
        setUpResetPasswordButton()
    }
    private func setUpEmailTextFieldConstraints() {
        resetPasswordEmailTextField.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordEmailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        resetPasswordEmailTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        resetPasswordEmailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetPasswordEmailTextField.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: textFieldTopMargin).isActive = true
    }
    private func setUpResetPasswordButton(){
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        resetButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetButton.topAnchor.constraint(equalTo: resetPasswordEmailTextField.bottomAnchor, constant: textFieldSpacing).isActive = true
    }
    private func createTextField(text: String) -> UITextField {
        let view = UITextField(frame: CGRect(x: 0, y: 0, width: textFieldWidth, height: textFieldHeight))
        view.backgroundColor = .white
        view.layer.cornerRadius = 4.07
        view.tintColor = .dark
        view.autocorrectionType = .no
        view.autocapitalizationType = .none
        view.spellCheckingType = .no
        view.delegate = self
        //view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        let frame = CGRect(x: 0, y: 0, width: textFieldHorizontalMargin, height: textFieldHeight)
        view.leftView = UIView(frame: frame)
        view.leftViewMode = .always

        view.rightView = UIView(frame: frame)
        view.rightViewMode = .always

        view.font = UIFont(name: "HelveticaNeue-Medium", size: 15)
        view.textColor = .text

        let attributes: [NSAttributedString.Key : Any] = [
            .foregroundColor: UIColor.disabledText,
            .font : view.font!
        ]

        view.attributedPlaceholder = NSAttributedString(string: text, attributes: attributes)

        return view
    }
    @objc private func resetPress(_ sender:UIButton){
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
