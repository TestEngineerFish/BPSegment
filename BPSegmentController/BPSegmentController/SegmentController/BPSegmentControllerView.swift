//
//  BPSegmentControllerView.swift
//  BPSegmentController
//
//  Created by 沙庭宇 on 2019/12/4.
//  Copyright © 2019 沙庭宇. All rights reserved.
//

import UIKit

protocol BPSegmentDataSource: NSObjectProtocol {

    /// 首选中Index
    func firstSelectedIndex() -> IndexPath?
    /// 设置Item数量
    func numbers() -> Int
    /// 设置标题Item的size
    func headerItemSize() -> CGSize
    /// 自定义Item视图
    func segment(_ segment: BPSegmentView, itemForRowAt indexPath: IndexPath) -> UIView
    /// 自定义Content视图
    func segment(_ segment: BPSegmentView, contentForRowAt indexPath: IndexPath) -> UIView
}

extension BPSegmentDataSource {

    /// 首选中Index
    func firstSelectedIndex() -> IndexPath? {
        return nil
    }
    /// 设置Item数量
    func numbers() -> Int {
        return 0
    }
    /// 设置标题Item的size
    func headerItemSize() -> CGSize {
        return CGSize.zero
    }
    /// 自定义Item视图
    func segment(_ segment: BPSegmentView, itemForRowAt indexPath: IndexPath) -> UIView {
        return UIView()
    }
    /// 自定义Content视图
    func segment(_ segment: BPSegmentView, contentForRowAt indexPath: IndexPath) -> UIView {
        return UIView()
    }
}

class BPSegmentControllerView: UIView, UICollectionViewDataSource, UICollectionViewDelegate {

    // ---- 数据
    var titleArray: [String]?
    final let headerItemSize = CGSize(width: 50, height: 50)
    final let contentITemSize = CGSize(width: 400, height: 1000)
    final let headerItemIdf  = "BPItemView"
    final let contentItemIdf = "BPItemContentView"
    var lastSelectedIndex =  IndexPath()
    // ---- 子视图
    var headerScrollView: BPSegmentView!
    var contentScrollView: BPSegmentView!
    var headerFlowLayout: UICollectionViewFlowLayout!
    var contentFlowLayout: UICollectionViewFlowLayout!

    weak var delegate: BPSegmentDataSource?

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.bindData()
        self.createSubviews()
    }

    deinit {
        headerScrollView.delegate    = nil
        contentScrollView.delegate   = nil
        headerScrollView.dataSource  = nil
        contentScrollView.dataSource = nil
        headerScrollView  = nil
        contentScrollView = nil
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func bindData() {
        self.lastSelectedIndex = self.delegate?.firstSelectedIndex() ?? IndexPath(item: 0, section: 0)
    }

    private func createSubviews() {
        headerFlowLayout = UICollectionViewFlowLayout()
        headerFlowLayout.scrollDirection         = .horizontal
        headerFlowLayout.itemSize                = headerItemSize
        headerFlowLayout.minimumInteritemSpacing = 0
        headerFlowLayout.sectionInset            = UIEdgeInsets.zero

        contentFlowLayout = UICollectionViewFlowLayout()
        contentFlowLayout.scrollDirection         = .horizontal
        contentFlowLayout.itemSize                = contentITemSize
        contentFlowLayout.minimumInteritemSpacing = 0
        contentFlowLayout.sectionInset            = UIEdgeInsets.zero
        
        let headerFrame  = CGRect(x: 0, y: 0, width: self.frame.width, height: headerItemSize.height)
        headerScrollView = BPSegmentView(frame: headerFrame, collectionViewLayout: headerFlowLayout)
        let contentFrame = CGRect(x: 0, y: headerScrollView.frame.maxY, width: self.frame.width, height: self.frame.height - headerScrollView.frame.height)
        contentScrollView = BPSegmentView(frame: contentFrame, collectionViewLayout: contentFlowLayout)

        self.addSubview(headerScrollView)
        self.addSubview(contentScrollView)

        headerScrollView.register(BPItemHeaderView.classForCoder(), forCellWithReuseIdentifier: headerItemIdf)
        contentScrollView.register(BPItemContentView.classForCoder(), forCellWithReuseIdentifier: contentItemIdf)

        headerScrollView.delegate      = self
        headerScrollView.dataSource    = self
        contentScrollView.delegate     = self
        contentScrollView.dataSource   = self

        headerScrollView.isHeaderView  = true
        contentScrollView.isHeaderView = false

        headerScrollView.isPagingEnabled  = false
        contentScrollView.isPagingEnabled = true
    }

    // TODO: ==== UICollectionViewDataSource ====
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let number = self.delegate?.numbers() ?? 0
        return number
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let segmentView = collectionView as? BPSegmentView else {
            return UICollectionViewCell()
        }

        if segmentView.isHeaderView {
            // 通过注册获取View
            guard let _itemView = collectionView.dequeueReusableCell(withReuseIdentifier: headerItemIdf, for: indexPath) as? BPItemHeaderView else {
                return UICollectionViewCell()
            }
            // 获取自定义View,如果有的话
            if let itemSubview = self.delegate?.segment(segmentView, itemForRowAt: indexPath) {
                _itemView.contentView.addSubview(itemSubview)
            }
            // 设置选中状态
            if self.lastSelectedIndex == indexPath {
                _itemView.isSelected = true
            } else {
                _itemView.isSelected = false
            }
            // 设置标识符
            _itemView.tag = indexPath.row
            return _itemView
        } else {
            // 通过注册获取View
            guard let _contentView = collectionView.dequeueReusableCell(withReuseIdentifier: contentItemIdf, for: indexPath) as? BPItemContentView else {
                return UICollectionViewCell()
            }
            // 获取自定义View,如果有的话
            if let contentSubview = self.delegate?.segment(segmentView, contentForRowAt: indexPath){
                _contentView.contentView.addSubview(contentSubview)
            }
            // 设置选中状态
            if self.lastSelectedIndex == indexPath {
                _contentView.isSelected = true
            } else {
                _contentView.isSelected = false
            }
            // 设置标识符
            _contentView.tag = indexPath.row
            return _contentView
        }
    }

    // TODO: ==== UICollectionViewDelegate ====
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // 滑动
        guard let segmentView = collectionView as? BPSegmentView else {
            return
        }
        if segmentView.isHeaderView {
            // 设置当前选中效果
            guard let cell = collectionView.cellForItem(at: indexPath) as? BPItemHeaderView else {
                return
            }
            cell.isSelected = true
            // 移除上一次选中效果
            guard let lastCell = collectionView.cellForItem(at: self.lastSelectedIndex) as? BPItemHeaderView else {
                return
            }
            lastCell.isSelected = false
        } else {
            // 设置当前选中效果
            guard let cell = collectionView.cellForItem(at: indexPath) as? BPItemContentView else {
                return
            }
            cell.isSelected = true
            // 移除上一次选中效果
            guard let lastCell = collectionView.cellForItem(at: self.lastSelectedIndex) as? BPItemContentView else {
                return
            }
            lastCell.isSelected = false
        }
        // 滑动到对应视图
        self.headerScrollView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.contentScrollView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        // 更新选中
        self.lastSelectedIndex = indexPath
    }

    // MARK: ==== UIScrollViewDelegate ====
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        print(scrollView.contentOffset)
    }

    // TODO: ==== Tools ====

}

