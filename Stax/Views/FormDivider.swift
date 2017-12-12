//
//  FormDivider.swift
//  Stax
//
//  Created by icbrahimc on 12/11/17.
//  Copyright © 2017 icbrahimc. All rights reserved.
//

import Foundation
import UIKit

class FormDivider: UIView {
    
    var dividerText: String = "OR"
    
    var leftLine = UIView.newAutoLayout()
    var rightLine = UIView.newAutoLayout()
    var label = UILabel.newAutoLayout()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    init(dividerText: String) {
        self.dividerText = dividerText
        self.init()
    }
    
    func setup() {
        addSubview(leftLine)
        addSubview(rightLine)
        addSubview(label)
        
        label.text = dividerText
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        
        leftLine.backgroundColor = .black
        rightLine.backgroundColor = .black
        
        leftLine.autoSetDimension(.height, toSize: 1)
        leftLine.autoPinEdge(toSuperviewEdge: .left, withInset: 0)
        leftLine.autoAlignAxis(toSuperviewAxis: .horizontal)
        leftLine.autoPinEdge(.right, to: .left, of: label, withOffset: -10)
        
        label.autoAlignAxis(toSuperviewAxis: .vertical)
        label.autoPinEdge(toSuperviewEdge: .top, withInset: 0)
        label.autoPinEdge(toSuperviewEdge: .bottom, withInset: 0)
        
        rightLine.autoSetDimension(.height, toSize: 1)
        rightLine.autoPinEdge(toSuperviewEdge: .right, withInset: 0)
        rightLine.autoAlignAxis(toSuperviewAxis: .horizontal)
        rightLine.autoPinEdge(.left, to: .right, of: label, withOffset: 10)
    }
}
