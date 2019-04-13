//
//  GenericEvents.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation

struct Created<T>: Event {
    let item: T
}

struct Selected<T>: Event {
    var item: T
}

struct Loaded<T>: Event {
    var item: T
}

struct Deselected<T>: Event { }

struct Updated<T>: Event {
    var item: T
}

struct Added<T>: Event {
    var item: T
}

struct Deleted<T>: Event {
    var item: T
}

struct Reset<T>: Event {
    var customReset: ((T) -> T)?
}

struct ErrorDisplayed: Event { }

struct AuthenticationFailed: Event {
    let message: String
}

struct AuthenticationSucceeded: Event { }

struct LoggedIn: Event { }

struct LoggedOut: Event { }

struct DisplayedDetail: Event { }

struct Refreshed: Event { }
