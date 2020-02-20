import UIKit

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.navigationItem.hidesBackButton = true
        self.tabBarController?.navigationItem.title = K.chatTitle
        self.tabBarController?.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "ellipsis"), style: .plain, target: self, action: #selector(addItem2))
    }
    
    @objc func addItem2(){
        print("From Chat")
    }
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

}

extension ChatViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if(indexPath.row % 2 == 0){
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.inchatCell, for: indexPath) as! InChatCell
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: K.Cells.outchatCell, for: indexPath) as! OutChatCell
            return cell
        }
        
    }
    
}

extension ChatViewController: UITableViewDelegate{
    
}
