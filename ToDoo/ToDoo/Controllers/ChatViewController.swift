import UIKit
import Firebase

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    let db = Firestore.firestore()
    var messages: [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: K.Cells.inchatXib, bundle: nil), forCellReuseIdentifier: K.Cells.inchatCell)
        tableView.register(UINib(nibName: K.Cells.outchatXib, bundle: nil), forCellReuseIdentifier: K.Cells.outchatCell)
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 80
        //        tableView.tableFooterView = UIView()
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = K.chatTitle
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(addItem2))
        Shared.sharedInstance.badgeNum = nil
        loadMessages()
    }
    
    @objc func addItem2(){
        print("From Chat")
    }
    
    func loadMessages(){
        if let messageSender = Auth.auth().currentUser?.email{
            let chatColRef = db.collection(K.FStore.userCollection).document(messageSender).collection(K.FStore.chatCollection)
            
            chatColRef.order(by: K.FStore.dateField).addSnapshotListener { (querySnapshot, error) in
                self.messages = []
                if let e = error{
                    print(e.localizedDescription)
                }else{
                    if let snapshotDocument = querySnapshot?.documents{
                        for doc in snapshotDocument{
                            let data = doc.data()
                            if let isIncoming = data[K.FStore.isIncomingField] as? Bool, let messageBody = data[K.FStore.bodyField] as? String{
                                self.messages.append(Message(body: messageBody, isIncoming: isIncoming))
                            }
                        }
                    }
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                        if self.messages.count > 1{
                            self.tableView.scrollToRow(at: IndexPath(row: self.messages.count - 1, section: 0), at: .top, animated: false)
                        }
                    }
                }
            }
        }
    }
}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(messages[indexPath.row].isIncoming){
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.inchatCell, for: indexPath) as! InChatCell
            cell.message = messages[indexPath.row]
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.outchatCell, for: indexPath) as! OutChatCell
            cell.message = messages[indexPath.row]
            return cell
        }
        
    }
    
}

extension ChatViewController: UITableViewDelegate{
    
}

