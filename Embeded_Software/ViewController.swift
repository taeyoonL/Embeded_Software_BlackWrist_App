//
//  ViewController.swift
//  Embeded_Software
//
//  Created by 이태윤 on 2023/08/10.
//

import UIKit
import MessageUI

class ViewController: UIViewController, MFMessageComposeViewControllerDelegate {

    @IBOutlet var label_1: UILabel!
    
    @IBOutlet var label_2: UILabel!
    @IBOutlet var label_3: UILabel!
    
    @IBOutlet var label_4: UILabel!
    
    @IBOutlet var label_5: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        label_1.text = "Black Wrist을(를) 통해,"
        label_2.text = "LSD 마약이 감지되었습니다."
        label_3.text = "자동으로 사법 기관에 연락이 진행되며,"
        label_4.text = "이를 무시하고 싶으신 경우, 30초 안에 Bar를 밀어주세요."
        Timer.scheduledTimer(timeInterval: 30.0, target: self, selector: #selector(ViewController.send_auto_message), userInfo: nil, repeats: false)
    }

    
    
    
    @IBAction func no_slider(_ sender: UISlider) {
        let value = sender.value
        if value == 1 {
            UIApplication.shared.perform(#selector(NSXPCConnection.suspend))
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                exit(0)
            }
        }
    }
    
    @objc func send_auto_message(){
        let phone_number = "01082129547"
        let message = "현재 마약에 노출되었습니다. 빨리 와주세요. 현재 저의 위치는 ~~~ 입니다."
        sendTextMessage(to: phone_number, message: message)
    }
    
    func sendTextMessage(to phoneNumber: String, message: String) {
            if MFMessageComposeViewController.canSendText() {
                let messageController = MFMessageComposeViewController()
                messageController.recipients = [phoneNumber]
                messageController.body = message
                messageController.messageComposeDelegate = self
                present(messageController, animated: true, completion: nil)
                
            } else {
                print("문자 메시지를 보낼 수 없습니다.")
            }
        }

    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        switch result {
            case.cancelled:
                label_5.text = "메시지 전송이 취소되었습니다."
            case .sent:
                label_5.text = "메시지가 전송되었습니다."
            case .failed:
                label_5.text = "메시지 전송을 실패하였습니다."
            @unknown default:
                break
            }
        controller.dismiss(animated: true, completion: nil)
    }
}

