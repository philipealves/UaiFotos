//
//  ProfileEditViewController.swift
//  Uai Fotos
//
//  Created by Jean on 14/12/2017.
//  Copyright © 2017 Uai Fotos. All rights reserved.
//

import UIKit
import Eureka
import IQKeyboardManagerSwift
import FirebaseAuth
import SwiftMessages

class ProfileEditViewController: FormViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        var uaifotosDS = UaiFotosDataStore()
        
        var user = UaiFotosDataStore().userCurrent
        var userName : String?
        var email : String?
        var website : String?
        var gender : String?
        var phone : String?
        var birthday : String?
        
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
            +++ Section("Perfil")
            <<< NameRow() { row in
                row.tag = "userName"
                row.title = "Nome:"
                row.placeholder = "digite aqui seu nome"
                row.value = user?.name
                }.cellUpdate { cell, row in
                    cell.textField.textAlignment = .left
                }.onChange { row in
                    
                    if row.value != nil {
                        userName = row.value!
                    }
            }
            <<< EmailRow() { row in
                row.tag = "email"
                row.title = "E-mail:"
                row.placeholder = "digite aqui seu e-mail"
                row.value = user?.email
                }.cellUpdate { cell, row in
                    cell.textField.textAlignment = .left
                }.onChange { row in
                    
                    if row.value != nil {
                        email = row.value!
                    }
            }
            <<< URLRow() { row in
                row.tag = "website"
                row.title = "Web Site:"
                row.placeholder = "digite aqui seu Web Site"
                if user?.website! != nil{
                    row.value = URL(fileReferenceLiteralResourceName: (user?.website!)!)
                }
                }.cellUpdate { cell, row in
                    cell.textField.textAlignment = .left
                }.onChange { row in
                    
                    if row.value != nil {
                        website = String(describing: row.value!)
                    }
            }
            <<< PhoneRow(){ row in
                row.title = "Telefone:"
                row.placeholder = "Digite o número do seu telefone"
                row.value = user?.phone
                
                }.cellUpdate { cell, row in
                    cell.textField.textAlignment = .left
                }.onChange { row in
                    if row.value != nil {
                        phone = row.value!
                    }
            }
            <<< DateRow(){row in
                row.title = "Data de Aniversário:"
                if user?.birthday != nil {
                    let strTime = user?.birthday!
                    let formatter = DateFormatter()
                    formatter.dateFormat = "yyyy-MM-dd HH:mm:ss Z"
                    formatter.locale = NSLocale(localeIdentifier: "us") as Locale!
                    formatter.timeZone = NSTimeZone(abbreviation: "GMT+0:00") as TimeZone!
                    let dateAssing = formatter.date(from: strTime!)!
                    row.value = dateAssing
                    birthday = String(describing: row.value!)
                }
                }.onChange { row in
                    let newDate = row.value!
                    birthday = String(describing: newDate)
            }
            <<< ActionSheetRow<String>() { row in
                row.tag = "gender"
                row.selectorTitle = "Sexo:"
                row.options = ["Masculino","Feminino"]
                row.title = "Sexo:"
                if user?.gender != nil {
                    row.value = user?.gender
                }
                }.onChange { row in
                    gender = row.value!
            }
            +++ Section()
            <<< ButtonRow { row in
                row.title = "Editar Perfil"
                
                row.cellUpdate({(cell, _)  in cell.textLabel?.textColor = UIColor.white
                    cell.backgroundColor = primaryLightColor})
                row.onCellSelection({ (_, _) in
                    guard let userName = userName else {
                        SwiftMessages.errorMessage(title: "Atenção:", body: "O campo nome é obrigatório")
                        return
                    }
                    guard let emailName = email else {
                        SwiftMessages.errorMessage(title: "Atenção:", body: "O campo e-mail é obrigatório")
                        return
                    }
                    
                    user?.name = userName
                    user?.email = email
                    user?.birthday = birthday
                    user?.gender = gender
                    user?.phone = phone
                    user?.website = website
                    
                    self.performSegueProfile()
                })
            }
            +++ Section()
            <<< ButtonRow { row in
                row.title = "Voltar"
                
                row.cellUpdate({(cell, _)  in cell.textLabel?.textColor = UIColor.white
                    cell.backgroundColor = primaryColor})
                row.onCellSelection({ (_, _) in
                    
                    self.performSegueProfile()
                })
            }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()

    }
    
    private func performSegueProfile(){
        let storyboard = UIStoryboard(name: "Profile", bundle: nil)
        let controller = storyboard.instantiateInitialViewController()!
        
        UIApplication.shared.delegate?.window??.rootViewController = controller
        UIApplication.shared.delegate?.window??.makeKeyAndVisible()
        
    }

}
