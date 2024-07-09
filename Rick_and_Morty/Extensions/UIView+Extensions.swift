//
//  UIView+Extensions.swift
//  Rick_and_Morty
//
//  Created by James Tochukwu Nwankwo on 08/07/2024.
//

import UIKit
import SwiftUI

public extension UIView {
    var top: CGFloat {
        frame.origin.y
    }
    
    var bottom: CGFloat {
        frame.size.height + top
    }
    
    var left: CGFloat {
        frame.origin.x
    }
    
    var width: CGFloat {
        frame.size.width
    }
    
    var height: CGFloat {
        frame.size.height
    }
    
    var right: CGFloat {
        left + width
    }
    
    func addSubiews(_ subviews: [UIView]) {
        subviews.forEach { addSubview($0) }
    }
    
    func positionView(
        topAnchor: NSLayoutYAxisAnchor? = nil,
        bottomAnchor: NSLayoutYAxisAnchor? = nil,
        leadingAnchor: NSLayoutXAxisAnchor? = nil,
        trailingAnchor: NSLayoutXAxisAnchor? = nil,
        padding: UIEdgeInsets = .zero,
        height: CGFloat = .zero,
        width: CGFloat = .zero) {
            self.translatesAutoresizingMaskIntoConstraints = false
            if let topAnchor = topAnchor {
                self.topAnchor.constraint(equalTo: topAnchor, constant: padding.top).isActive = true
            }
            
            if let bottomAnchor = bottomAnchor {
                self.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding.bottom).isActive = true
            }
            
            if let leadingAnchor = leadingAnchor {
                self.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding.left).isActive = true
            }
            
            if let trailingAnchor = trailingAnchor {
                self.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding.right).isActive = true
            }
            
            if height > .zero {
                constraintHeight(height)
            }
            
            if width > .zero {
                constraintWidth(width)
            }
        }
    
    func constraintSize(
        height: CGFloat = .zero,
        width: CGFloat = .zero) {
            if height > .zero {
                constraintHeight(height)
            }
            
            if width > .zero {
                constraintWidth(width)
            }
        }
    
    func constraintHeight(_ constant: CGFloat) {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
        heightAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func constraintWidth(_ constant: CGFloat) {
        if translatesAutoresizingMaskIntoConstraints {
            translatesAutoresizingMaskIntoConstraints = false
        }
        widthAnchor.constraint(equalToConstant: constant).isActive = true
    }
    
    func fillParentView(padding: UIEdgeInsets = .zero) {
        positionView(
            topAnchor: superview?.topAnchor,
            bottomAnchor: superview?.bottomAnchor,
            leadingAnchor: superview?.leadingAnchor,
            trailingAnchor: superview?.trailingAnchor,
            padding: padding)
    }
    
    func centerInParent(
        xConstant: CGFloat = .zero,
        yConstant: CGFloat = .zero) {
            if translatesAutoresizingMaskIntoConstraints {
                translatesAutoresizingMaskIntoConstraints = false
            }
            if let superviewCenterXAnchor = superview?.centerXAnchor {
                centerXAnchor.constraint(equalTo: superviewCenterXAnchor, constant: xConstant).isActive = true
            }
            
            if let superviewCenterYAnchor = superview?.centerYAnchor {
                centerYAnchor.constraint(equalTo: superviewCenterYAnchor, constant: yConstant).isActive = true
            }
            
        }
    
    func fillParentViewWithSafeAreaLayout(padding: UIEdgeInsets = .zero) {
        positionView(
            topAnchor: superview?.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: superview?.safeAreaLayoutGuide.bottomAnchor,
            leadingAnchor: superview?.leadingAnchor,
            trailingAnchor: superview?.trailingAnchor,
            padding: padding)
    }
    
    func fillParentViewWithSafeAreaTop(padding: UIEdgeInsets = .zero) {
        positionView(
            topAnchor: superview?.safeAreaLayoutGuide.topAnchor,
            bottomAnchor: superview?.bottomAnchor,
            leadingAnchor: superview?.leadingAnchor,
            trailingAnchor: superview?.trailingAnchor,
            padding: padding)
    }
    
    func constraintWidthToParentView(layout: NSLayoutDimension? = nil, padding: CGFloat = 0) {
        translatesAutoresizingMaskIntoConstraints = false
        if let layout = layout {
            widthAnchor.constraint(equalTo: layout, constant: padding).isActive = true
        } else {
            if let superViewWidthAnchor = superview?.widthAnchor {
                widthAnchor.constraint(equalTo: superViewWidthAnchor, constant: padding).isActive = true
            }
        }
    }
    
    func bounceAnimation(completion: (() -> Void)? = nil) {
        alpha = 0
        UIView.animate(withDuration: 0.25, delay: 0, usingSpringWithDamping: 0.2,
                       initialSpringVelocity: 10, options: [], animations: { [weak self] in
            self?.transform = CGAffineTransform(translationX: 2, y: -5)
            self?.alpha = 1
        }) { [weak self] _ in
            self?.transform = .identity
            completion?()
        }
    }
    
    func fadeAnimation(completion: (() -> Void)? = nil) {
        alpha = 0.2
        translatesAutoresizingMaskIntoConstraints = false
        UIView.animate(withDuration: 0.7, animations: { [weak self] in
            self?.alpha = 1
        })
    }
    
    func stopAnimation() {
        UIView.animate(withDuration: 0.5) { [weak self] in
            self?.transform = .identity
        }
    }
    
    func buttonScaleAnimation(
        scaleX: CGFloat = 0.93,
        scaleY: CGFloat = 0.8,
        duration: Double = 0.2
    ) {
        UIView.animate(
            withDuration: duration,
            delay: .zero,
            options: [.allowUserInteraction]) { [weak self] in
                self?.transform = CGAffineTransform(scaleX: scaleX, y: scaleY)
            } completion: { [weak self] _ in
                self?.stopAnimation()
            }
    }
}

struct BorderedText: ViewModifier {
    let backgroundColor: Color
    let foregroundStyle: AnyShapeStyle
    
    init(backgroundColor: Color = .sinbadBlue,
         foregroundStyle: AnyShapeStyle = .init(.white)) {
        self.backgroundColor = backgroundColor
        self.foregroundStyle = foregroundStyle
    }
    
    func body(content: Content) -> some View {
        content
            .padding(10)
            .foregroundStyle(foregroundStyle)
            .background(backgroundColor)
            .fontWeight(.semibold)
            .gridColumnAlignment(.leading)
    }
}

extension View {
    func borderedText(
        backgroundColor: Color = .sinbadBlue,
        foregroundStyle: AnyShapeStyle = .init(.white)) -> some View {
        modifier(BorderedText(backgroundColor: backgroundColor, foregroundStyle: foregroundStyle))
    }
}
