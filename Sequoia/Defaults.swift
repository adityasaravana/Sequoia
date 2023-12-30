//
//  Defaults.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/29/23.
//

import Defaults

extension Defaults.Keys {
    static let showTriageKeybindGuide = Key<Bool>("showTriageKeybindGuide", default: true)
    //            ^            ^         ^                ^
    //           Key          Type   UserDefaults name   Default value
}
