//
//  ViewController.swift
//  LostSocks
//
//  Created by Tomas Sykora, jr. on 26/10/2016.
//  Copyright © 2016 AJTY, s.r.o. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	override func viewDidLoad() {
		super.viewDidLoad()
	}
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        APIWrapper.loginUser(username: "user", password: "pass" , completionHandler: { success in
            if success {
                APIWrapper.getSocks(completionHandler: { (socks) in
                    print("Count of socks: \(socks.count)")
                })
            } else {
                
            }
        
        })
        
        
        
    }

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}


}

