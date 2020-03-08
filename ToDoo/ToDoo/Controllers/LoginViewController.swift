import UIKit
import Firebase
import Toast_Swift

private let buttonFrame = CGRect(x: 0, y: 0, width: buttonWidth, height: buttonHeight)
private let buttonHeight = textFieldHeight
private let buttonHorizontalMargin = textFieldHorizontalMargin / 2
private let buttonImageDimension: CGFloat = 18
private let buttonVerticalMargin = (buttonHeight - buttonImageDimension) / 2
private let buttonWidth = (textFieldHorizontalMargin / 2) + buttonImageDimension
private let critterViewDimension: CGFloat = 160
private let critterViewFrame = CGRect(x: 0, y: 0, width: critterViewDimension, height: critterViewDimension)
private let critterViewTopMargin: CGFloat = 30
private let textFieldHeight: CGFloat = 37
private let textFieldHorizontalMargin: CGFloat = 16.5
private let textFieldSpacing: CGFloat = 22
private let resetPasswordFieldSpacing: CGFloat = 66
private let textFieldTopMargin: CGFloat = 38.8
private let textFieldWidth: CGFloat = 206
private let loginFrame = CGRect(x: 0, y: 0, width: 160, height: 22)

final class LoginViewController: UIViewController, UITextFieldDelegate {

    private let critterView = CritterView(frame: critterViewFrame)

    private lazy var emailTextField: UITextField = {
        let textField = createTextField(text: "Email")
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        return textField
    }()

    private lazy var passwordTextField: UITextField = {
        let textField = createTextField(text: "Password")
        textField.isSecureTextEntry = true
        textField.returnKeyType = .go
        textField.rightView = showHidePasswordButton
        showHidePasswordButton.isHidden = true
        return textField
    }()
    
    private lazy var showHidePasswordButton: UIButton = {
        let button = UIButton(type: .custom)
        button.imageEdgeInsets = UIEdgeInsets(top: buttonVerticalMargin, left: 0, bottom: buttonVerticalMargin, right: buttonHorizontalMargin)
        button.frame = buttonFrame
        button.tintColor = .text
        button.setImage(#imageLiteral(resourceName: "Password-show"), for: .normal)
        button.setImage(#imageLiteral(resourceName: "Password-hide"), for: .selected)
        button.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton:UIButton = {
        let button = UIButton(type:.custom)
        button.backgroundColor = .light
        button.tintColor = .dark
        button.frame = loginFrame
        button.setTitle("Login", for: .normal)
        button.setTitleColor(.text, for: .normal)
        button.layer.cornerRadius = textFieldHeight/2
        button.addTarget(self, action: #selector(loginPress(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var resetPasswordButton:UIButton = {
        let button = UIButton(type:.custom)
//        button.backgroundColor = .light
//        button.tintColor = .dark
        button.frame = loginFrame
        button.setTitle("Forgot password?", for: .normal)
        button.setTitleColor(.text, for: .normal)
        button.setTitleColor(hexStringToUIColor(hex: "EDEDED"), for: .normal)
//        button.layer.cornerRadius = textFieldHeight/2
        button.addTarget(self, action: #selector(resetPasswordPress(_:)), for: .touchUpInside)
        return button
    }()
    
    private let notificationCenter: NotificationCenter = .default

    deinit {
        notificationCenter.removeObserver(self)
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        setUpView()
    }

    // MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let deadlineTime = DispatchTime.now() + .milliseconds(100)

        if textField == emailTextField {
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                let fractionComplete = self.fractionComplete(for: textField)
                self.critterView.startHeadRotation(startAt: fractionComplete)
                self.passwordDidResignAsFirstResponder()
            }
        }
        else if textField == passwordTextField {
            DispatchQueue.main.asyncAfter(deadline: deadlineTime) {
                self.critterView.isShy = true
                self.showHidePasswordButton.isHidden = false
            }
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == emailTextField {
            passwordTextField.becomeFirstResponder()
        }
        else {
            passwordTextField.resignFirstResponder()
            passwordDidResignAsFirstResponder()
        }
        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField == emailTextField {
            critterView.stopHeadRotation()
        }
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard !critterView.isActiveStartAnimating, textField == emailTextField else { return }

        let fractionComplete = self.fractionComplete(for: textField)
        critterView.updateHeadRotation(to: fractionComplete)

        if let text = textField.text {
            critterView.isEcstatic = text.contains("@")
        }
    }

    // MARK: - Private

    private func setUpView() {
        view.backgroundColor = .dark

        view.addSubview(critterView)
        setUpCritterViewConstraints()

        view.addSubview(emailTextField)
        setUpEmailTextFieldConstraints()

        view.addSubview(passwordTextField)
        setUpPasswordTextFieldConstraints()
        //MARK: - added login button
        view.addSubview(loginButton)
        setUpLoginButton()
        view.addSubview(resetPasswordButton)
        setUpResetPasswordButton()
        
        
        setUpGestures()
        setUpNotification()
    }

    private func setUpCritterViewConstraints() {
        critterView.translatesAutoresizingMaskIntoConstraints = false
        critterView.heightAnchor.constraint(equalToConstant: critterViewDimension).isActive = true
        critterView.widthAnchor.constraint(equalTo: critterView.heightAnchor).isActive = true
        critterView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        critterView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: critterViewTopMargin).isActive = true
    }

    private func setUpEmailTextFieldConstraints() {
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        emailTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        emailTextField.topAnchor.constraint(equalTo: critterView.bottomAnchor, constant: textFieldTopMargin).isActive = true
    }

    private func setUpPasswordTextFieldConstraints() {
        passwordTextField.translatesAutoresizingMaskIntoConstraints = false
        passwordTextField.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        passwordTextField.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        passwordTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: textFieldSpacing).isActive = true
    }
    
    private func setUpLoginButton() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        loginButton.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        loginButton.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        loginButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: textFieldSpacing).isActive = true
    }
    
    private func setUpResetPasswordButton() {
        resetPasswordButton.translatesAutoresizingMaskIntoConstraints = false
        resetPasswordButton.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        resetPasswordButton.widthAnchor.constraint(equalToConstant: textFieldWidth).isActive = true
        resetPasswordButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        resetPasswordButton.topAnchor.constraint(equalTo: loginButton.bottomAnchor, constant: resetPasswordFieldSpacing).isActive = true
    }
    

    private func fractionComplete(for textField: UITextField) -> Float {
        guard let text = textField.text, let font = textField.font else { return 0 }
        let textFieldWidth = textField.bounds.width - (2 * textFieldHorizontalMargin)
        return min(Float(text.size(withAttributes: [NSAttributedString.Key.font : font]).width / textFieldWidth), 1)
    }

    private func stopHeadRotation() {
        emailTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        critterView.stopHeadRotation()
        passwordDidResignAsFirstResponder()
    }

    private func passwordDidResignAsFirstResponder() {
        critterView.isPeeking = false
        critterView.isShy = false
        showHidePasswordButton.isHidden = true
        showHidePasswordButton.isSelected = false
        passwordTextField.isSecureTextEntry = true
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
        view.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

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

    // MARK: - Gestures

    private func setUpGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func handleTap() {
        stopHeadRotation()
    }

    // MARK: - Actions
    @objc private func loginPress(_ sender:UIButton){
        //press login
        if let email = emailTextField.text, let password = passwordTextField.text{
            Auth.auth().signIn(withEmail: email, password: password) {authResult, error in
                if let e = error{
                    self.view.makeToast(e.localizedDescription, duration: 2.5, position: .center)
                }else{
                    let vc = UIStoryboard.init(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "tabBarController") as! UITabBarController
                    self.navigationController?.pushViewController(vc, animated: true)
                    
                    
                }
            }
        }
    }
    @objc private func resetPasswordPress(_ sender:UIButton)
    {
        let vc = ResetPasswordViewController()
        self.navigationController?.pushViewController(vc, animated: true)
        //present(vc, animated: true, completion: nil)
    }
    @objc private func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        let isPasswordVisible = sender.isSelected
        passwordTextField.isSecureTextEntry = !isPasswordVisible
        critterView.isPeeking = isPasswordVisible
        if let textRange = passwordTextField.textRange(from: passwordTextField.beginningOfDocument, to: passwordTextField.endOfDocument), let password = passwordTextField.text {
            passwordTextField.replace(textRange, withText: password)
        }
    }

    // MARK: - Notifications

    private func setUpNotification() {
        notificationCenter.addObserver(self, selector: #selector(applicationDidEnterBackground), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    @objc private func applicationDidEnterBackground() {
        stopHeadRotation()
    }
}
