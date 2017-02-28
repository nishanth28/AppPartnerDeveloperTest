//
//  RoundedButton.swift
//  iOSTest
//
//  Created by Nishanth P on 2/14/17.
//  Copyright © 2017 AppPartner. All rights reserved.
//

import UIKit

class RoundedButton: UIButton {

    
     override func draw(_ rect: CGRect) {
        
        layer.cornerRadius = 25.0
        layer.masksToBounds = true
        

    }
}
