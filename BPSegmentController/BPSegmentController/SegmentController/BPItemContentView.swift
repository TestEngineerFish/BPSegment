//
//  BPItemContentView.swift
//  BPSegmentController
//
//  Created by 沙庭宇 on 2019/12/4.
//  Copyright © 2019 沙庭宇. All rights reserved.
//

import UIKit

class BPItemContentView: UICollectionViewCell {

    override init(frame: CGRect) {
        super.init(frame: frame)
        let _alpha = Int.random(in: 0..<11)
        self.backgroundColor = UIColor.orange.withAlphaComponent(CGFloat(_alpha)/10.0)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bindData(_ title: String) {
        self.contentView.backgroundColor = UIColor.orange
    }
}
