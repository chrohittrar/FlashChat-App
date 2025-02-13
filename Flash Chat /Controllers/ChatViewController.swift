//
//  ChatViewController.swift
//  Flash Chat iOS13
//
//  Created by Rohit Kumar on 12/01/2024
//

import UIKit
import FirebaseCore
import FirebaseFirestore
import FirebaseAuth

class ChatViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextfield: UITextField!
    
    let db = Firestore.firestore()
    
    var messages : [Message] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        tableView.dataSource = self
        title = K.AppName
        navigationItem.hidesBackButton = true
        
        tableView.register(UINib(nibName: K.cellNibName, bundle: nil), forCellReuseIdentifier: K.cellIdentifier)
        
        loadMessages()
    }
    
    func loadMessages(){
        
        
        db.collection(K.FStore.collectionName)
            .order(by: K.FStore.dateField)
            .addSnapshotListener { QuerySnapshot, error in
            
            self.messages = []

            
            if let e = error{
                print("There was na issues retreving the data from the Firestore \(e)")
            }else{
                if let snapshotDocuments = QuerySnapshot?.documents{
                    for doc in snapshotDocuments{
                        let data =  doc.data()
                        if let messageSender = data[K.FStore.senderField] as? String , let messageBody = data[K.FStore.bodyField] as? String{
                            
                            let newMessage = Message(sender: messageSender, body: messageBody)
                            self.messages.append(newMessage)
                            
                            
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                                
                                let indexPath = IndexPath(row: self.messages.count-1 , section: 0)
                                self.tableView.scrollToRow(at: indexPath, at: .top, animated: true)
                            }
                        }
                    }
                }
            }
        }
    }
    
    
    @IBAction func sendPressed(_ sender: UIButton) {
        
        if let messageBody = messageTextfield.text, let messageSender = Auth.auth().currentUser?.email{
            
            db.collection(K.FStore.collectionName)
                .addDocument(data: [K.FStore.senderField : messageSender, K.FStore.bodyField: messageBody , K.FStore.dateField: Date().timeIntervalSince1970] ) { (error) in
                if let e = error{
                    print("There is some issues in saving data to the FireStore: \(e)")
                }else{
                    print("Saved Successfully to the FireStore")
                }
            }
            
        }
        
        messageTextfield.text = ""
         
    }
    
    @IBAction func logOutPressed(_ sender: UIBarButtonItem) {
        
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
            
        }
        catch let signOutError as NSError
        {
            print("Error signing out: %@", signOutError)
        }
    }
}

extension ChatViewController : UITableViewDataSource{
    func tableView(_ tableView: UITableView,  numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let message = messages[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: K.cellIdentifier , for: indexPath) as! MessageCell
        cell.label.text = message.body
        
        
        // This message buble design when messenger is sent by me
        if message.sender == Auth.auth().currentUser?.email{
            cell.youAvatar.isHidden = true
            cell.meAvatar.isHidden = false
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.lightPurple)
            cell.label.textColor = UIColor(named: K.BrandColors.purple)
        }
        
        //This the message bubble design when message is sent by another person
        else{
            cell.youAvatar.isHidden = false
            cell.meAvatar.isHidden  = true
            cell.messageBubble.backgroundColor = UIColor(named: K.BrandColors.purple)
            cell.label.textColor = UIColor(named: K.BrandColors.lightPurple)
        }
        
        
        return cell
    }
    
     
}
