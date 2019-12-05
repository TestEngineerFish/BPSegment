//
//  ViewController.swift
//  BPSegmentController
//
//  Created by 沙庭宇 on 2019/12/4.
//  Copyright © 2019 沙庭宇. All rights reserved.
//

import UIKit

class ViewController: UIViewController, BPSegmentDataSource {

    var segmentView:BPSegmentControllerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let segmentFrame = CGRect(x: 0, y: 200, width: self.view.bounds.width, height: 500)
        segmentView = BPSegmentControllerView(frame: segmentFrame)
        segmentView.delegate = self
        self.view.addSubview(segmentView)
    }

    // TODO: ==== BPSegmentDataSource ====

    /// 设置Item数量
    func numbers() -> Int {
        return 30
    }
    /// 设置标题Item的size
    func headerItemSize() -> CGSize {
        return CGSize(width: 50, height: 50)
    }
    /// 自定义Item视图
    func segment(_ segment: BPSegmentView, itemForRowAt indexPath: IndexPath) -> UIView {
        let itemView = CustomItemView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 50, height: 50)))
        itemView.bindData("你好")
        return itemView
    }
    /// 自定义Content视图
//    func segment(_ segment: BPSegmentView, contentForRowAt indexPath: IndexPath) -> UIView {
//
//        let contentView = CustomItemView(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 500)))
//        contentView.bindData("nonon")
//        return contentView
//    }

}

