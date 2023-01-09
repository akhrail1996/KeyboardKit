//
//  StringProvider.swift
//  KeyboardKit
//
//  Created by Daniel Saidi on 2022-11-28.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol is shared between protocols that use a string
 to enable their functionality.

 This approach will be used within the library to reduce the
 number of extensions, and instead rewrite them as protocols.

 This protocol is implemented by `String`.
 */
public protocol StringProvider {

    var string: String { get }
}

extension String: StringProvider {

    public var string: String { self }
}
