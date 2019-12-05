//
//  ExtensionView.swift
//  BPSegmentController
//
//  Created by 沙庭宇 on 2019/12/5.
//  Copyright © 2019 沙庭宇. All rights reserved.
//

import UIKit

extension CALayer {
    /// 宽度
    var width: CGFloat {
        get {
            return self.frame.size.width
        }

        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    /// 高度
    var height: CGFloat {
        get {
            return self.frame.size.height
        }

        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    /// 左上角的顶点,在父控件中的位置
    var origin: CGPoint {
        get {
            return self.frame.origin
        }

        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }

    /// 尺寸大小
    var size: CGSize {
        get {
            return self.frame.size
        }

        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
}

extension UIView {
    /// 宽度
    var width: CGFloat {
        get {
            return self.frame.size.width
        }

        set {
            var frame = self.frame
            frame.size.width = newValue
            self.frame = frame
        }
    }

    /// 高度
    var height: CGFloat {
        get {
            return self.frame.size.height
        }

        set {
            var frame = self.frame
            frame.size.height = newValue
            self.frame = frame
        }
    }

    /// 左上角的顶点,在父控件中的位置
    var origin: CGPoint {
        get {
            return self.frame.origin
        }

        set {
            var frame = self.frame
            frame.origin = newValue
            self.frame = frame
        }
    }

    /// 尺寸大小
    var size: CGSize {
        get {
            return self.frame.size
        }

        set {
            var frame = self.frame
            frame.size = newValue
            self.frame = frame
        }
    }
}
