//
//  SliderControlView.swift
//  BLE LED Demo
//
//  Created by Johnathan Grayson on 18/12/14.
//  Copyright (c) 2014 Johnathan Grayson. All rights reserved.
//

import UIKit

class SliderControlView: UIView {

    override func awakeFromNib() {
        
        let slider : SliderControl = SliderControl(frame: self.bounds)
        
        self.addSubview(slider)
        
    }

}
