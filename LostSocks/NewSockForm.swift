//
//  NewSockForm.swift
//  LostSocks
//
//  Created by Tomas Sykora, jr. on 13/11/2016.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import Foundation
import Eureka
import ImageRow

class NewSockForm: FormViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save,
                                                            target: self,
                                                            action: #selector(NewSockForm.save))
        form = Section("Sock basic info")
            <<< TextRow(){ row in
                row.title = "Name"
                row.placeholder = "Name your lost sock!"
                row.tag = "name"
            }
            <<< TextAreaRow(){
                $0.title = "Description"
                $0.placeholder = "Describe during which ocasion you lost this sock, how it looked like and how used it was."
                $0.tag = "d"
            }
            
            <<< ImageRow(){
                $0.title = "ImageRow"
                $0.tag = "image"
            }
            +++ Section("Location")
            <<< LocationRow(){
                $0.title = "Where have you lost it?"
                $0.tag = "coordinates"
            }
        
    }
    
    func save() {
        
        let sock = Sock(formValues: form.values())
        print(sock)
        APIWrapper.storeSock(sock, completionHandler: { sock in
            print(sock)
        } )
        
    }
}
