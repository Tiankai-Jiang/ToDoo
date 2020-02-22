import UIKit
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var currentEditing: Int = 0
    let storage = Storage.storage()
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.Cells.profileImageXib, bundle: nil), forCellReuseIdentifier: K.Cells.profileImageCell)
        
        tableView.register(UINib(nibName: K.Cells.logoutXib, bundle: nil), forCellReuseIdentifier: K.Cells.logoutCell)
        
        tableView.register(UINib(nibName: K.Cells.setNameXib, bundle: nil), forCellReuseIdentifier: K.Cells.setNameCell)
        
        tableView.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = K.settingsTitle
        self.tabBarController?.navigationItem.rightBarButtonItem = nil
        
    }
    
    func handleSelectProfileImageView(isMyself: Int){
        let pickerController = UIImagePickerController()
        pickerController.delegate = self
        present(pickerController, animated: true, completion: nil)
    }
    
    func handleSelectProfilePhotoUpload(selectedImage: UIImage){
        if let currentUser = Auth.auth().currentUser?.email{
            let imageRef = storage.reference(forURL: "gs://todoo-a1fcd.appspot.com").child(currentUser + "/" + String(currentEditing) + ".jpg")
            if let imageData = selectedImage.jpegData(compressionQuality: 0.1){
                imageRef.putData(imageData, metadata: nil) { (metadata, error) in
                    if let e = error{
                        print(e.localizedDescription)
                        return
                    }else{
                        loadImages()
                    }
                }
            }
        }

    }
    
}

extension SettingsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 2 ? 1 : 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.profileImageCell, for: indexPath) as! ProfileImageCell
            cell.imageLabel.text = indexPath.row == 0 ? "Your profile image" : "Bot profile image"
            cell.profileImage.image = indexPath.row == 0 ? Shared.sharedInstance.profileImage : Shared.sharedInstance.botImage
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.setNameCell, for: indexPath) as! SetNameCell
            cell.nameLabel.text = indexPath.row == 0 ? "Name called by your bot" : "Your bot name"
            cell.nickname.text = indexPath.row == 0 ? Shared.sharedInstance.userName : Shared.sharedInstance.botName
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.logoutCell, for: indexPath) as! LogoutCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 36
    }
    
    @objc func textFieldDidChange(_ sender: UITextField) {
        guard let alertController = presentedViewController as? UIAlertController else {
            return
        }
        let alertButton = alertController.actions[1]
        if let e = sender.text {
            let text = e.trimmingCharacters(in: .whitespaces)
            alertButton.isEnabled = !text.isEmpty
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            currentEditing = indexPath.row
            handleSelectProfileImageView(isMyself: indexPath.row)
        }else if(indexPath.section == 1){
            
            let alertController = UIAlertController(title: "Please enter a new name", message: nil, preferredStyle: .alert)
            alertController.addTextField { (textField : UITextField!) -> Void in
                textField.addTarget(self, action: #selector(self.textFieldDidChange(_:)),
                for: .editingChanged)
            }

            
            let saveAction = UIAlertAction(title: "Save", style: .default, handler: { alert -> Void in
                if let textField = alertController.textFields?[0] {
                    if let currentUser = Auth.auth().currentUser?.email{
                        let userRef = self.db.collection(K.FStore.userCollection).document(currentUser)
                        let field = indexPath.row == 0 ? K.FStore.usernameField : K.FStore.botnameField
                        userRef.updateData([field : textField.text!]) { (error) in
                            if let e = error{
                                print(e.localizedDescription)
                            }else{
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            })
            
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: {
                (action : UIAlertAction!) -> Void in })
            
            alertController.addAction(cancelAction)
            alertController.addAction(saveAction)
            alertController.actions[1].isEnabled = false
            alertController.preferredAction = saveAction
            self.present(alertController, animated: true, completion: nil)
            
        }else{
            do{
                try Auth.auth().signOut()
                if let window = UIApplication.shared.windows.first {
                    let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
                    let rootVC = mainStoryboard.instantiateViewController(withIdentifier: "navController")
                    window.rootViewController = rootVC
                }
                UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
                navigationController?.popToRootViewController(animated: true) // why no animation????
            }catch let signOutError as NSError{
                print(signOutError)
            }
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}

extension SettingsViewController: UITableViewDelegate{
    
}

extension SettingsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage{
            let cell = tableView.cellForRow(at: IndexPath(row: currentEditing, section: 0)) as! ProfileImageCell
            cell.profileImage.image = image
            handleSelectProfilePhotoUpload(selectedImage: image)
        }
        dismiss(animated: true, completion: nil)
    }
}
