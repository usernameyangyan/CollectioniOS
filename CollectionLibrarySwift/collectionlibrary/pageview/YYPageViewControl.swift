//
//  YYPageViewControl.swift
//  CollectionLibrarySwift
//
//  Created by Huatu on 2019/12/29.
//  Copyright © 2019 YoungManSter. All rights reserved.
//

import UIKit


@IBDesignable
public class YYPageViewControl:UIControl{
    
    @IBInspectable
    open var numberOfPages: Int = 0 {
        didSet {
            self.setNeedsCreateIndicators()
        }
    }
    
    @IBInspectable
    open var currentPage: Int = 0 {
        didSet {
            self.setNeedsUpdateIndicators()
        }
    }
    
    @IBInspectable
    open var itemSpacing: CGFloat = 6 {
        didSet {
            self.setNeedsUpdateIndicators()
        }
    }
    
    @IBInspectable
    open var interitemSpacing: CGFloat = 6 {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    open var contentInsets: UIEdgeInsets = .zero {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    open override var contentHorizontalAlignment: UIControl.ContentHorizontalAlignment {
        didSet {
            self.setNeedsLayout()
        }
    }
    
    @IBInspectable
    open var hidesForSinglePage: Bool = false {
        didSet {
            self.setNeedsUpdateIndicators()
        }
    }
    
    internal var strokeColors: [UIControl.State: UIColor] = [:]
    internal var fillColors: [UIControl.State: UIColor] = [:]
    internal var paths: [UIControl.State: UIBezierPath] = [:]
    internal var images: [UIControl.State: UIImage] = [:]
    internal var alphas: [UIControl.State: CGFloat] = [:]
    internal var transforms: [UIControl.State: CGAffineTransform] = [:]
    
    fileprivate weak var contentView: UIView!
    
    fileprivate var needsUpdateIndicators = false
    fileprivate var needsCreateIndicators = false
    fileprivate var indicatorLayers = [CAShapeLayer]()
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    open override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = {
            let x = self.contentInsets.left
            let y = self.contentInsets.top
            let width = self.frame.width - self.contentInsets.left - self.contentInsets.right
            let height = self.frame.height - self.contentInsets.top - self.contentInsets.bottom
            let frame = CGRect(x: x, y: y, width: width, height: height)
            return frame
        }()
    }
    
    open override func layoutSublayers(of layer: CALayer) {
        super.layoutSublayers(of: layer)
        
        let diameter = self.itemSpacing
        let spacing = self.interitemSpacing
        var x: CGFloat = {
            switch self.contentHorizontalAlignment {
            case .left, .leading:
                return 0
            case .center, .fill:
                let midX = self.contentView.bounds.midX
                let amplitude = CGFloat(self.numberOfPages/2) * diameter + spacing*CGFloat((self.numberOfPages-1)/2)
                return midX - amplitude
            case .right, .trailing:
                let contentWidth = diameter*CGFloat(self.numberOfPages) + CGFloat(self.numberOfPages-1)*spacing
                return contentView.frame.width - contentWidth
            default:
                return 0
            }
        }()
        for (index,value) in self.indicatorLayers.enumerated() {
            let state: UIControl.State = (index == self.currentPage) ? .selected : .normal
            let image = self.images[state]
            let size = image?.size ?? CGSize(width: diameter, height: diameter)
            let origin = CGPoint(x: x - (size.width-diameter)*0.5, y: self.contentView.bounds.midY-size.height*0.5)
            value.frame = CGRect(origin: origin, size: size)
            x = x + spacing + diameter
        }
        
    }
    

    @objc(setStrokeColor:forState:)
    open func setStrokeColor(_ strokeColor: UIColor?, for state: UIControl.State) {
        guard self.strokeColors[state] != strokeColor else {
            return
        }
        self.strokeColors[state] = strokeColor
        self.setNeedsUpdateIndicators()
    }
    
   
    @objc(setFillColor:forState:)
    open func setFillColor(_ fillColor: UIColor?, for state: UIControl.State) {
        guard self.fillColors[state] != fillColor else {
            return
        }
        self.fillColors[state] = fillColor
        self.setNeedsUpdateIndicators()
    }
    
    @objc(setImage:forState:)
    open func setImage(_ image: UIImage?, for state: UIControl.State) {
        guard self.images[state] != image else {
            return
        }
        self.images[state] = image
        self.setNeedsUpdateIndicators()
    }
    
    @objc(setAlpha:forState:)
    
  
    open func setAlpha(_ alpha: CGFloat, for state: UIControl.State) {
        guard self.alphas[state] != alpha else {
            return
        }
        self.alphas[state] = alpha
        self.setNeedsUpdateIndicators()
    }
    
   
    @objc(setPath:forState:)
    open func setPath(_ path: UIBezierPath?, for state: UIControl.State) {
        guard self.paths[state] != path else {
            return
        }
        self.paths[state] = path
        self.setNeedsUpdateIndicators()
    }
    

    fileprivate func commonInit() {
        
        // Content View
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor.clear
        self.addSubview(view)
        self.contentView = view
        self.isUserInteractionEnabled = false
        
    }
    
    fileprivate func setNeedsUpdateIndicators() {
        self.needsUpdateIndicators = true
        self.setNeedsLayout()
        DispatchQueue.main.async {
            self.updateIndicatorsIfNecessary()
        }
    }
    
    fileprivate func updateIndicatorsIfNecessary() {
        guard self.needsUpdateIndicators else {
            return
        }
        guard self.indicatorLayers.count > 0 else {
            return
        }
        self.needsUpdateIndicators = false
        self.contentView.isHidden = self.hidesForSinglePage && self.numberOfPages <= 1
        if !self.contentView.isHidden {
            self.indicatorLayers.forEach { (layer) in
                layer.isHidden = false
                self.updateIndicatorAttributes(for: layer)
            }
        }
    }
    
    fileprivate func updateIndicatorAttributes(for layer: CAShapeLayer) {
        let index = self.indicatorLayers.firstIndex(of: layer)
        let state: UIControl.State = index == self.currentPage ? .selected : .normal
        if let image = self.images[state] {
            layer.strokeColor = nil
            layer.fillColor = nil
            layer.path = nil
            layer.contents = image.cgImage
        } else {
            layer.contents = nil
            let strokeColor = self.strokeColors[state]
            let fillColor = self.fillColors[state]
            if strokeColor == nil && fillColor == nil {
                layer.fillColor = (state == .selected ? UIColor.white : UIColor.gray).cgColor
                layer.strokeColor = nil
            } else {
                layer.strokeColor = strokeColor?.cgColor
                layer.fillColor = fillColor?.cgColor
            }
            layer.path = self.paths[state]?.cgPath ?? UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: self.itemSpacing, height: self.itemSpacing)).cgPath
        }
        if let transform = self.transforms[state] {
            layer.transform = CATransform3DMakeAffineTransform(transform)
        }
        layer.opacity = Float(self.alphas[state] ?? 1.0)
    }
    
    fileprivate func setNeedsCreateIndicators() {
        self.needsCreateIndicators = true
        DispatchQueue.main.async {
            self.createIndicatorsIfNecessary()
        }
    }
    
    fileprivate func createIndicatorsIfNecessary() {
        guard self.needsCreateIndicators else {
            return
        }
        self.needsCreateIndicators = false
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        if self.currentPage >= self.numberOfPages {
            self.currentPage = self.numberOfPages - 1
        }
        self.indicatorLayers.forEach { (layer) in
            layer.removeFromSuperlayer()
        }
        self.indicatorLayers.removeAll()
        for _ in 0..<self.numberOfPages {
            let layer = CAShapeLayer()
            layer.actions = ["bounds": NSNull()]
            self.contentView.layer.addSublayer(layer)
            self.indicatorLayers.append(layer)
        }
        self.setNeedsUpdateIndicators()
        self.updateIndicatorsIfNecessary()
        CATransaction.commit()
    }
    
    func cleanUp(){
           setStrokeColor(nil, for: .normal)
           setStrokeColor(nil, for: .selected)
           setFillColor(nil, for: .normal)
           setFillColor(nil, for: .selected)
           setImage(nil, for: .normal)
           setImage(nil, for: .selected)
           setPath(nil, for: .normal)
           setPath(nil, for: .selected)
       }
    
}

extension UIControl.State: Hashable {
    public var hashValue: Int {
        return Int((6777*self.rawValue+3777)%UInt(UInt16.max))
    }
}
