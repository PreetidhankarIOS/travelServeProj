//
//  chatViewOfBookingIdViewController.swift
//  travelServe
//
//  Created by Developer on 19/10/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

protocol ChatViewControllerDelegateID: class {
    func didNewChatMessagesRecieved() -> ()
    
}

class chatViewOfBookingIdViewController: UIViewController {
 var fileBookingId = String()
    
    //MARK:- Properties
    var ChatViewModalId: chatViewModalId?
    
    @IBOutlet weak var bookingIdLib: UIBarButtonItem!
    @IBOutlet weak var ViewBgOfText: UIView!
     @IBOutlet weak var chatTXT: UITextField!
    @IBOutlet weak var mainTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
  self.bookingIdLib.title = fileBookingId
          ViewBgOfText.dropShadow()
          setUpInitializers()
        self.chat_informnation(DriverId: UserDetail.shared.getUserDriverId(), FileBooingId: fileBookingId)
      
    }
    
    
    @IBAction func backBtnAction(_ sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    
    
    deinit {
        print("ChatViewController de-initialized")
    }
      override func didReceiveMemoryWarning() {
          super.didReceiveMemoryWarning()
          // Dispose of any resources that can be recreated.
      }
    
      @IBAction func sendChat(_ sender: UIButton)
      {

          (chatTXT.text?.isEmpty)! ? nil : self.chat_informnationUpdate(DriverId: UserDetail.shared.getUserDriverId(), msg: chatTXT.text!, bookingId: fileBookingId)
          chatTXT.text = ""
      }
      

}

extension chatViewOfBookingIdViewController : KeyBoardNotificationDelegate,UITableViewDataSource,ChatViewControllerDelegateID{
    
    
    fileprivate func setUpInitializers()
    {
        KeyboardNotificationController.sharedKC.registerforKeyBoardNotification(delegate: self)
        addOnTapDismissKeyboard()
       ChatViewModalId = chatViewModalId(view: self)
    }
    
    fileprivate func scrollToBottom(){
        DispatchQueue.main.async {
            
            self.mainTableView.scrollToLastCell_P(animated: true)
        }
    }
    
    fileprivate func addOnTapDismissKeyboard() {
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.dismissKeyboard (_:)))
        self.view.addGestureRecognizer(tapGesture)
        print("**************Table view didSelect maynot work!!!!!!!!!!!!!!!")
    }
    
    @objc func dismissKeyboard (_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    fileprivate func addChat()
    {
        ChatViewModalId?.newchat = chatTXT.text
        ChatViewModalId?.onItemAdded()
        chatTXT.text = ""
    }
    
    //MARK: - ChatViewControllerDelegate
    
    func didNewChatMessagesRecieved() {
        mainTableView.reloadData()
        scrollToBottom()
    }
    
    //MARK: - KeyBoardNotificationDelegate
    
    func didKeyBoardAppeared(keyboardHeight: CGFloat) {
        
        //self.chatTXTBottomConstraint.constant = (keyboardHeight == 0) ? 0 : -keyboardHeight
        mainTableView.reloadData()
        scrollToBottom()
    }
    
    
      func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ChatViewModalId?.chatss.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()

        let obj = ChatViewModalId?.chatss[indexPath.row].chatUser // sender-receiver
        if obj == "User" {
            cell = tableView.dequeueReusableCell(withIdentifier: "leftbubblecell")!
                        let lccell = cell as! LeftChatCellID
            lccell.configureLeftChatCellID(chat: (ChatViewModalId?.chatss[indexPath.row])!)
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "rightbubblecell")!
            let rccell = cell as! RightChatCellID
            rccell.configureRightChatCellID(chat: (ChatViewModalId?.chatss[indexPath.row])!)
        }
        return cell

    }
    
}


class RightChatCellID: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var chatLBL: UILabel!
    @IBOutlet weak var timeLib: UILabel!
    
    //MARK: - View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureRightChatCellID(chat: Chate)
    {
        chatLBL.text = chat.chatMessage
        timeLib.text = chat.ChatTime
    }
}

class LeftChatCellID: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var chatLBL: UILabel!
     @IBOutlet weak var timeLib: UILabel!
    //MARK: - View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureLeftChatCellID(chat: Chate)
    {
        
        
        chatLBL.text = chat.chatMessage
        timeLib.text = chat.ChatTime
        
    }
}
