// The Swift Programming Language
// https://docs.swift.org/swift-book

import CoreGraphics
import Foundation

extension CGRect {
    public var center: CGPoint {
        CGPoint(x: self.midX, y: self.midY)
    }
}

extension CGPoint {
    // Add + operator
    public static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    // Add += operator
    public static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }

    // Add - operator
    public static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    // Add -= operator
    public static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }

    // Add * operator
    public static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }

    // Add *= operator
    public static func *= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs * rhs
    }

    // Add / operator
    public static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }

    // Add /= operator
    public static func /= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs / rhs
    }

    // Add * operator for memberWise multiplication
    public static func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }

    // Add *= operator for memberWise multiplication
    public static func *= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs * rhs
    }

    // Add / operator for memberWise division
    public static func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        CGPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }

    // Add /= operator for memberWise division
    public static func /= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs / rhs
    }

    // Add dot product
    public func dot(_ other: CGPoint) -> CGFloat {
        self.x * other.x + self.y * other.y
    }

    // Add magnitude
    public var magnitude: CGFloat {
        sqrt(self.x * self.x + self.y * self.y)
    }

    public var cgSize: CGSize {
        CGSize(width: self.x, height: self.y)
    }

    public init(cgSize: CGSize) {
        self.init(x: cgSize.width, y: cgSize.height)
    }

    public func distance(to other: CGPoint) -> CGFloat {
        (self - other).magnitude
    }

    //    func applying(_ transform: CGAffineTransform) -> CGPoint {
    //        return CGPointApplyAffineTransform(self, transform)
    //    }
    //
    public func applying(inverseOf transform: CGAffineTransform) -> CGPoint {
        CGPointApplyAffineTransform(self, CGAffineTransformInvert(transform))
    }
}

extension CGSize {
    public var cgPoint: CGPoint {
        CGPoint(x: self.width, y: self.height)
    }

    public init(cgPoint: CGPoint) {
        self.init(width: cgPoint.x, height: cgPoint.y)
    }

    //    func applying(_ transform: CGAffineTransform) -> CGSize {
    //        return CGSizeApplyAffineTransform(self, transform)
    //    }
    //
    public func applying(inverseOf transform: CGAffineTransform) -> CGSize {
        CGSizeApplyAffineTransform(self, CGAffineTransformInvert(transform))
    }

    // + operator
    public static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    // += operator
    public static func += (lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs + rhs
    }

    // - operator
    public static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    // -= operator
    public static func -= (lhs: inout CGSize, rhs: CGSize) {
        lhs = lhs - rhs
    }

    // / operator with CGFloat
    public static func / (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width / rhs, height: lhs.height / rhs)
    }

    // /= operator with CGFloat
    public static func /= (lhs: inout CGSize, rhs: CGFloat) {
        lhs = lhs / rhs
    }

    // * operator with CGFloat
    public static func * (lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width * rhs, height: lhs.height * rhs)
    }

    // *= operator with CGFloat
    public static func *= (lhs: inout CGSize, rhs: CGFloat) {
        lhs = lhs * rhs
    }
}
