//
//  CustomItemView.swift
//  BPSegmentController
//
//  Created by 沙庭宇 on 2019/12/4.
//  Copyright © 2019 沙庭宇. All rights reserved.
//

import UIKit

class CustomItemView: UIView {

    var titleLabel      = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.clear
        self.createSubviews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func createSubviews() {
        self.addSubview(titleLabel)

        titleLabel.frame = CGRect(x: 0, y: 0, width: self.frame.width, height: self.frame.height)

        titleLabel.font = UIFont.boldSystemFont(ofSize: 15)
        titleLabel.textColor = UIColor.white
        titleLabel.textAlignment = .center
    }

    func bindData(_ title: String) {
        self.titleLabel.text = title
    }
}
