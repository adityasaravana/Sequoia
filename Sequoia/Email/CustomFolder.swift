//
//  CustomFolder.swift
//  Sequoia
//
//  Created by Aditya Saravana on 12/28/23.
//

import Foundation

struct CustomFolder: Identifiable {
    let id = UUID()
    
    var name: String
    var folder: [Email]
}
