//
//  UIAlertController.swift
//  Veg Out Taiwan
//
//  Created by Irene.C on 2020/5/14.
//  Copyright © 2020 Irene.C. All rights reserved.
//

import UIKit

extension UIViewController{

    // Global Alert
    // Define Your number of buttons, styles and completion
    public func openAlert(title: String,
                          message: String,
                          alertStyle:UIAlertController.Style,
                          actionTitles:[String],
                          actionStyles:[UIAlertAction.Style],
                          actions: [((UIAlertAction) -> Void)]){

        let alertController = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for(index, indexTitle) in actionTitles.enumerated(){
            let action = UIAlertAction(title: indexTitle, style: actionStyles[index], handler: actions[index])
            alertController.addAction(action)
        }
        self.present(alertController, animated: true)
    }
}

//Usage

/*Alert
 
 self.openAlert(title: "alert",
  message: "add your message",
  alertStyle: .alert,
  actionTitles: ["Okay", "Cancel"],
  actionStyles: [.default, .cancel],
  actions: [
      {_ in
           print("okay click")
      },
      {_ in
           print("cancel click")
      }
 ])
 */

/*ActionSheet
 
 self.openAlert(title: "actionsheet",
  message: "add your message",
  alertStyle: .actionSheet,
  actionTitles: ["Okay", "Cancel"],
  actionStyles: [.default, .cancel],
  actions: [
      {_ in
           print("okay click")
      },
      {_ in
           print("cancel click")
      }
 ])
 */
