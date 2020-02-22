import UIKit
import Firebase

class SettingsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var currentEditing: Int = 0
    let storage = Storage.storage()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.Cells.profileImageXib, bundle: nil), forCellReuseIdentifier: K.Cells.profileImageCell)
        
        tableView.register(UINib(nibName: K.Cells.logoutXib, bundle: nil), forCellReuseIdentifier: K.Cells.logoutCell)
        
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
                    }
                }
            }
        }

    }
    
}

extension SettingsViewController: UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return section == 0 ? 2 : 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.profileImageCell, for: indexPath) as! ProfileImageCell
            cell.imageLabel.text = indexPath.row == 0 ? "Your profile image" : "Bot profile image"
            cell.profileImage.image = indexPath.row == 0 ? Shared.sharedInstance.profileImage : Shared.sharedInstance.botImage
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.logoutCell, for: indexPath) as! LogoutCell
            return cell
        }
        
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 0 : 24
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if(indexPath.section == 0){
            currentEditing = indexPath.row
            handleSelectProfileImageView(isMyself: indexPath.row)
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
