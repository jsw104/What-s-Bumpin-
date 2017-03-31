//
//  WYMaterialButton.swift
//  WYMaterialButton
//
//  Created by Wang Yu on 9/24/15.
//
//

import UIKit
import QuartzCore
import pop

let presetMaterialColor = UIColor(red:0.93, green:0.94, blue:0.95, alpha:0.2)

@IBDesignable
public class WYMaterialButton: DesignableButton {

    public var animationDuration = 0.6
    public var pulseDuration = 0.2
    
    @IBInspectable
    public var materialColor: UIColor = UIColor.clearColor() {
        didSet {
            self.materialBackgroundView.backgroundColor = self.materialColor
            self.backgroundColor                        = self.materialColor
            self.materialPressedColor                   = autoGenerateDeeperColor(self.materialColor)
        }
    }
    
    @IBInspectable
    public var materialPressedColor: UIColor = presetMaterialColor {
        didSet {
            self.materialPressedView.backgroundColor = self.materialPressedColor
        }
    }

    @IBInspectable
    public var pulseEnable: Bool = true
    @IBInspectable
    public var touchLocationEnable: Bool = true
    @IBInspectable
    public var materialEffectPercent: CGFloat = 0.9 {
        didSet {
            self.materialEffectPercent = self.materialEffectPercent * 1.1
            self.configureMaterialPressedView()
        }
    }
    
    public func autoGenerateDeeperColor(color: UIColor) -> UIColor {
        let colorComponent = CGColorGetComponents(color.CGColor)
        let newRed         = max(colorComponent[0] - 0.05, 0)
        let newGreen       = max(colorComponent[1] - 0.1, 0)
        let newBlue        = max(colorComponent[2] - 0.13, 0)
        return UIColor(red: newRed, green: newGreen, blue: newBlue, alpha: 1)
    }
    
    public func autoGenerateContrastColor(color: UIColor) -> UIColor {
        let colorComponent = CGColorGetComponents(color.CGColor)
        var d: CGFloat = 0
        let a = 1 - (0.299 * colorComponent[0] + 0.587 * colorComponent[1] + 0.114 * colorComponent[2])
        d = a < 0.5 ? 0 : 1
        return UIColor(red: d, green: d, blue: d, alpha: 1)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        let trackingCenter = self.materialPressedView.center
        self.configureMaterialPressedView()
        
        self.materialPressedView.center = self.touchLocationEnable ? trackingCenter : self.materialPressedView.center
        self.materialBackgroundView.layer.frame = self.bounds
        
        let buttonMask = CAShapeLayer()
        buttonMask.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: self.cornerRadius).CGPath
        self.materialBackgroundView.layer.mask = buttonMask
    }
    
    private func configure() {
        self.configureMaterialPressedView()
        self.configureMaterialBackgroundView()
        self.materialBackgroundView.alpha = 0
        self.addTarget(self, action: #selector(WYMaterialButton.scaleToSmall), forControlEvents: [.TouchDragEnter, .TouchDown])
        self.addTarget(self, action: #selector(WYMaterialButton.scaleAnimation), forControlEvents: .TouchUpInside)
        self.addTarget(self, action: #selector(WYMaterialButton.scaleToDefault), forControlEvents: .TouchDragExit)
    }
    
    func scaleToSmall() {
        guard pulseEnable else { return }
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(0.95, 0.95))
        self.layer.pop_addAnimation(scaleAnimation, forKey: "layerScaleSmallAnimation")
    }
    
    func scaleAnimation() {
        guard pulseEnable else { return }
        let scaleAnimation = POPSpringAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.velocity = NSValue(CGSize: CGSizeMake(3, 3))
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(1, 1))
        scaleAnimation.springBounciness = 18.0
        self.layer.pop_addAnimation(scaleAnimation, forKey: "layerScaleSpringAnimation")
    }
    
    func scaleToDefault() {
        guard pulseEnable else { return }
        let scaleAnimation = POPBasicAnimation(propertyNamed: kPOPLayerScaleXY)
        scaleAnimation.toValue = NSValue(CGSize: CGSizeMake(1, 1))
        self.layer.pop_addAnimation(scaleAnimation, forKey: "layerScaleDefaultAnimation")
    }
    
    let materialPressedView = UIView()
    private func configureMaterialPressedView() {
        let materialEffectBounds: CGFloat = self.bounds.width * materialEffectPercent
        self.materialPressedView.frame = CGRectMake(CGRectGetMidX(self.bounds) - materialEffectBounds/2, CGRectGetMidY(self.bounds) - materialEffectBounds/2, materialEffectBounds, materialEffectBounds)
        self.materialPressedView.backgroundColor = self.materialPressedColor
        self.materialPressedView.layer.cornerRadius = materialEffectBounds/2
    }
    
    let materialBackgroundView = UIView()
    private func configureMaterialBackgroundView() {
        self.materialBackgroundView.backgroundColor = self.materialColor
        self.materialBackgroundView.frame = self.bounds
        self.layer.addSublayer(materialBackgroundView.layer)
        self.materialBackgroundView.layer.addSublayer(self.materialPressedView.layer)
    }
    

    public override func beginTrackingWithTouch(touch: UITouch, withEvent event: UIEvent?) -> Bool {
        self.materialBackgroundView.alpha = 1
        self.materialPressedView.center = touch.locationInView(self)
        self.materialPressedView.transform = CGAffineTransformMakeScale(0.6, 0.6)

        
        UIView.animateWithDuration(animationDuration, delay: 0, options: [.CurveEaseOut, .AllowUserInteraction, .AllowAnimatedContent], animations: {
            self.materialPressedView.center = self.materialBackgroundView.center
            self.materialPressedView.transform = CGAffineTransformIdentity
        }, completion: nil)
        
        return super.beginTrackingWithTouch(touch, withEvent: event)
    }
    
    public override func cancelTrackingWithEvent(event: UIEvent?) {
        super.cancelTrackingWithEvent(event)
        UIView.animateWithDuration(0.1, delay: 0, options: [.AllowUserInteraction, .AllowAnimatedContent], animations: {
            self.materialBackgroundView.alpha = 1
        }) { _ in
            UIView.animateWithDuration(self.animationDuration, delay: 0, options: [.CurveEaseOut, .AllowUserInteraction], animations: { () -> Void in
                self.materialBackgroundView.alpha = 0
            }, completion: nil)
        }
    }
    
    public override func endTrackingWithTouch(touch: UITouch?, withEvent event: UIEvent?) {
        super.endTrackingWithTouch(touch, withEvent: event)
        UIView.animateWithDuration(0.1, delay: 0, options: [.AllowUserInteraction, .AllowAnimatedContent], animations: {
            self.materialBackgroundView.alpha = 1
        }) { _ in
            UIView.animateWithDuration(self.animationDuration, delay: 0, options: [.CurveEaseOut, .AllowUserInteraction], animations: { () -> Void in
                self.materialBackgroundView.alpha = 0
            }, completion: nil)
        }
    }
}
