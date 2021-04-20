//
//  chatViewController.swift
//  travelServe
//
//  Created by Developer on 27/06/2019.
//  Copyright © 2019 GorangaTech. All rights reserved.
//

import UIKit

protocol ChatViewControllerDelegate: class {
    func didNewChatMessagesRecieved() -> ()
    
}

class chatViewController: UIViewController {
    
    @IBOutlet weak var ViewBgOfText: UIView!
    //MARK: - IBOutlets
   // @IBOutlet weak var chatTXTBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var chatTable: UITableView!
   
    @IBOutlet weak var chatTXT: UITextField!
    var sendermessage = String ()

    
    //MARK:- Properties
    var chatviewmodel: ChatViewModel?
    
    //MARK: - View life cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       NotificationCenter.default.addObserver(self, selector: #selector(self.gernalChatNotificationMethod(notification:)), name: Notification.Name("GernalaChatNotification"), object: nil)
        setUpInitializers()
        
        self.chat_informnation(DriverId: UserDetail.shared.getUserDriverId())
        self.ViewBgOfText.dropShadow()
    }

    @objc func gernalChatNotificationMethod(notification: Notification) {
        
       // debugPrint(notification)

        if let dict = notification.userInfo as NSDictionary? {
            debugPrint(dict)
            var chats: [Chat] = []
            if let messag = dict["gcm.notification.Message"] as? String {
                debugPrint(messag)
                sendermessage = messag
            }
             let UserIde = dict["gcm.notification.UserId"] as? String
             let chatTime = dict["gcm.notification.UserId"] as? String
            let chat1 = Chat(arg_user: UserIde!, arg_pic: "", arg_message: sendermessage, chatTime: chatTime!)
            chats.append(chat1)
            self.chatviewmodel?.chats = chats
            self.chatTable.reloadData()
            self.chatTable.scrollToLastCell_P(animated: false)
        }
        
    }
    
    
    @IBAction func menuBtnAction(_ sender: UIBarButtonItem) {
        
        if let slideMenuController = self.slideMenuController() {
            slideMenuController.openLeft()
        }
        
    }
    
    @IBAction func bookingBtnAction(_ sender: UIButton) {
        
          let storyBord : UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
          let nextViewController = storyBord.instantiateViewController(withIdentifier: "bookingChatViewController") as! bookingChatViewController
          self.navigationController?.pushViewController(nextViewController, animated: true)
        
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

        (chatTXT.text?.isEmpty)! ? nil : self.chat_informnationUpdate(DriverId: UserDetail.shared.getUserDriverId(), msg: chatTXT.text!, bookingId: "NoBookingId")
        chatTXT.text = ""
    }
    
}

extension chatViewController: KeyBoardNotificationDelegate,UITableViewDataSource,ChatViewControllerDelegate
{

    
    //MARK: - Custom Accessors
    
    fileprivate func setUpInitializers()
    {
        KeyboardNotificationController.sharedKC.registerforKeyBoardNotification(delegate: self)
        addOnTapDismissKeyboard()
        chatviewmodel = ChatViewModel(view: self)
    }
    
    fileprivate func scrollToBottom(){
        DispatchQueue.main.async {

            self.chatTable.scrollToLastCell_P(animated: true)
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
        chatviewmodel?.newchat = chatTXT.text
        chatviewmodel?.onItemAdded()
        chatTXT.text = ""
    }
    
    //MARK: - ChatViewControllerDelegate
    
    func didNewChatMessagesRecieved() {
        chatTable.reloadData()
        scrollToBottom()
    }
    
    //MARK: - KeyBoardNotificationDelegate
    
    func didKeyBoardAppeared(keyboardHeight: CGFloat) {
        
        //self.chatTXTBottomConstraint.constant = (keyboardHeight == 0) ? 0 : -keyboardHeight
        chatTable.reloadData()
        scrollToBottom()
    }
    
    
    //MARK: - UITableViewDataSource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatviewmodel?.chats.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        var cell = UITableViewCell()

        let obj = chatviewmodel?.chats[indexPath.row].chatUser // sender-receiver
        if obj == "User" {
            cell = tableView.dequeueReusableCell(withIdentifier: "leftbubblecell")!
                        let lccell = cell as! LeftChatCell
            lccell.configureLeftChatCell(chat: (chatviewmodel?.chats[indexPath.row])!)
        }else{
            cell = tableView.dequeueReusableCell(withIdentifier: "rightbubblecell")!
            let rccell = cell as! RightChatCell
            rccell.configureRightChatCell(chat: (chatviewmodel?.chats[indexPath.row])!)
        }
        return cell

        
    }
    

}

class RightChatCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var chatLBL: UILabel!
    @IBOutlet weak var timeLib: UILabel!
    
    //MARK: - View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureRightChatCell(chat: Chat)
    {
        chatLBL.text = chat.chatMessage
        timeLib.text = chat.ChatTime
    }
}

class LeftChatCell: UITableViewCell {
    
    //MARK: - IBOutlets
    
    @IBOutlet weak var chatLBL: UILabel!
     @IBOutlet weak var timeLib: UILabel!
    //MARK: - View life cycle
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
    
    func configureLeftChatCell(chat: Chat)
    {
        
        
        chatLBL.text = chat.chatMessage
        timeLib.text = chat.ChatTime
        
    }
}

