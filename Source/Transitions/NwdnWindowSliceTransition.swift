//
//  NwdnWindowSliceTransition.swift
//  MTTransitions
//
//  Created by yang on 2021/10/25.
//

import Foundation

public class NwdnWindowSliceTransition: MTTransition {
    
    public var count: Float = 10

    public var smoothness: Float = 0.5

    override var fragmentName: String {
        return "NwdnWindowSliceFragment"
    }

    override var parameters: [String: Any] {
        return [
            "count": count,
            "smoothness": smoothness
        ]
    }
}

