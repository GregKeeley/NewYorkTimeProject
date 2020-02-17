//
//  EmptyView.swift
//  NewYorkTimeProject
//
//  Created by Gregory Keeley on 2/17/20.
//  Copyright © 2020 Gregory Keeley. All rights reserved.
//

import UIKit

class EmptyView: UIView {
    public lazy var titleLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .headline)
        label.numberOfLines = 1
        label.textAlignment = .center
        label.text = "Empty collection"
        return label
    }()
    public lazy var messageLabel: UILabel =  {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 0
        label.textAlignment = .center
        label.text = "There are no items currently in your collection"
        return label
    }()
    
    init(title: String, message: String) {
         super.init(frame: UIScreen.main.bounds)
         self.titleLabel.text = title
         self.messageLabel.text = message
         commonInit()
     }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    private func commonInit() {
        constraintsMessageLabel()
        constraintsTitleLabel()
        
    }
    private func constraintsMessageLabel() {
        addSubview(messageLabel)
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            messageLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            messageLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.95)
        
        ])
    }
    private func constraintsTitleLabel() {
        addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
        
            titleLabel.bottomAnchor.constraint(equalTo: messageLabel.topAnchor, constant: -8),
                        titleLabel.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width * 0.95),
                        titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor)
            
        ])
    }

}
