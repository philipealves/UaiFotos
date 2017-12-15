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
        self.form =
            Section(){ section in
                section.header = {
                    var header = HeaderFooterView<UIView>(.callback({
                        let view = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 65))
                        view.backgroundColor = primaryColor
                        return view
                    }))
                    header.height = { 40 }
                    return header
                }()
            }
            +++ Section("Login:")
            <<< TextRow() { row in
                row.tag = "email"
                row.title = "e-mail"
                row.placeholder = "digite aqui seu email"
                
                }.cellUpdate { cell, row in
                    cell.textField.textAlignment = .left
            }
            <<< TextRow() { row in
                row.tag = "password"
                row.title = "Senha"
                row.placeholder = "digite aqui sua senha"
                
                }.cellUpdate { cell, row in
                    cell.textField.textAlignment = .left
                    cell.textField.isSecureTextEntry = true
            }
            +++ Section()
            <<< ButtonRow { row in
                row.title = "Entrar"

                row.onCellSelection({ (_, _) in
                    let emailRow: TextRow? = self.form.rowBy(tag: "email")
                    guard let email = emailRow?.value else {
                        SwiftMessages.errorMessage(title: "Atenção:", body: "O campo e-mail é obrigatório")
                        return
                    }
                    
                    let passwordRow: TextRow? = self.form.rowBy(tag: "password")
                    guard let password = passwordRow?.value else {
                        SwiftMessages.errorMessage(title: "Atenção:", body: "O campo senha é obrigatório")
                        return
                    }
                    
                    self.performLogin(email, password)
                })
            }
            +++ Section()
            <<< ButtonRow { row in
                row.title = "Iniciar Cadastro"

                row.onCellSelection({ (_, _) in
                    var confirmPasswordRow: TextRow?
                    let emailRow: TextRow? = self.form.rowBy(tag: "email")
                    guard let email = emailRow?.value else {
                        SwiftMessages.errorMessage(title: "Atenção:", body: "O campo e-mail é obrigatório")
                        return
                    }

                    self.form +++ Section()
                    <<< TextRow() { row in
                        row.tag = "confirmPassword"
                        row.title = "Confirme sua Senha"
                        row.placeholder = "digite aqui sua senha novamente"
                        
                        }.cellUpdate { cell, row in
                            cell.textField.textAlignment = .left
                            cell.textField.isSecureTextEntry = true
                        }
                    +++ Section()
                    <<< ButtonRow { row in
                        row.title = "Cadastrar"
                        
                        row.onCellSelection({ (_, _) in
                            
                            let passwordRow: TextRow? = self.form.rowBy(tag: "password")
                            guard let password = passwordRow?.value else {
                                SwiftMessages.errorMessage(title: "Atenção:", body: "O campo senha é obrigatório.")
                                return
                            }
                            
                            confirmPasswordRow = self.form.rowBy(tag: "confirmPassword")
                            guard let confirmPassword = confirmPasswordRow?.value else {
                                SwiftMessages.errorMessage(title: "Atenção:", body: "O campo confirmação de senha é obrigatório.")
                                return
                            }
                            
                            if password != confirmPassword {
                                SwiftMessages.errorMessage(title: "Atenção:", body: "O campo confirmação de senha é diferente da senha digitada.")
                                return
                            }
                            
                            self.performCreateLogin((emailRow?.value)!, (password))
                            
                        })
                    }
                })
            }
            +++ Section()
            <<< ButtonRow { row in
                row.title = "Voltar"
                
                row.cellUpdate({(cell, _)  in cell.textLabel?.textColor = UIColor.white
                    cell.backgroundColor = primaryColor})
                row.onCellSelection({ (_, _) in
                    
                    self.performSegueBack()
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
            else
            {
                if let userFI = user as? User {
                    UaiFotosDataStore.user?.email = userFI.email
                }
                self.performSegueMain()
            }
        }
    }
    
    private func performCreateLogin(_ email: String, _ password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { (user, error) in
            if error != nil {
                SwiftMessages.infoMessage(title: "Importante:", body: error!.localizedDescription)
            }
            else
            {
                self.performSegueMain()
            }
        }
    }
    
    private func performSegueMain(){
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        
        UIApplication.shared.delegate?.window??.rootViewController = controller
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
        
    }
    
    private func performSegueBack(){
        let storyboard = UIStoryboard(name: "Login", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        
        UIApplication.shared.delegate?.window??.rootViewController = controller
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
        
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


