//
//  NwdnSquaresWireTransition.swift
//  MTTransitions
//
//  Created by yang on 2021/10/25.
//

import Foundation
import MetalPetal


public class NwdnSquaresWireTransition: MTTransition {
    
    public var direction: CGPoint = CGPoint(x: 1.0, y: -0.5)

    public var squares: SIMD2<Int32> = SIMD2(10, 10)

    public var smoothness: Float = 1.6

    override var fragmentName: String {
        return "NwdnSquaresWireFragment"
    }

    override var parameters: [String: Any] {
        return [
            "direction": MTIVector(value: direction),
            "squares": MTIVector(value: squares),
            "smoothness": smoothness
        ]
    }
}
