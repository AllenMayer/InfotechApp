//
//  UIHelper.swift
//  InfotechApp
//
//  Created by Максим Семений on 19.08.2020.
//  Copyright © 2020 Максим Семений. All rights reserved.
//

import UIKit

final class UIHelper {
    
    static func layoutViews(inView: UIView, nextImageView: UIImageView, toInitialImageView: UIImageView, alignNextLabel: UILabel, toInitialLabel: UILabel, previousLabel: UILabel) {
        nextImageView.centerXAnchor.constraint(equalTo: toInitialImageView.centerXAnchor).isActive = true
        alignNextLabel.leadingAnchor.constraint(equalTo: toInitialLabel.leadingAnchor).isActive = true
        inView.addConstraintsWithFormat(format: "V:[v0]-20-[v1(30)]", views: previousLabel, nextImageView)
        inView.addConstraintsWithFormat(format: "H:[v0(30)]", views: nextImageView)
        alignNextLabel.centerYAnchor.constraint(equalTo: nextImageView.centerYAnchor).isActive = true
    }
}
