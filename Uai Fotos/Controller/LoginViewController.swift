//
//  LoginViewController.swift
//  UaiTreino
//
//  Created by Elifazio Bernardes da Silva on 05/12/2017.
//  Copyright © 2017 Uai Treino Ltda. All rights reserved.
//

import UIKit
import Eureka
import IQKeyboardManagerSwift
import FirebaseAuth
import SwiftMessages

class LoginViewController: FormViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        IQKeyboardManager.sharedManager().enable = true
        self.form +++ Section("Login:")
            <<< TextRow() { row in
                row.tag = "email"
                row.title = "e-mail"
                row.placeholder = "digite aqui seu email"
            }
            <<< TextRow() { row in
                row.tag = "password"
                row.title = "Senha"
                row.placeholder = "digite aqui sua senha"
            }
            +++ Section()
            <<< ButtonRow { row in
                row.title = "Entrar"

                row.onCellSelection({ (_, _) in
                    let emailRow: TextRow? = self.form.rowBy(tag: "email")
                    guard let email = emailRow?.value else {
                        SwiftMessages.errorMessage(title: "Ocorreu um erro:", body: "O campo e-mail é obrigatório")
                        return
                    }
                    
                    let passwordRow: TextRow? = self.form.rowBy(tag: "password")
                    guard let password = passwordRow?.value else {
                        SwiftMessages.errorMessage(title: "Ocorreu um erro:", body: "O campo senha é obrigatório")
                        return
                    }
                    
                    self.performLogin(email, password)
                })
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func performLogin(_ email: String, _ password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                SwiftMessages.infoMessage(title: "Importante:", body: error!.localizedDescription)
            }
            print(user)
        }
    }
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
    
}
