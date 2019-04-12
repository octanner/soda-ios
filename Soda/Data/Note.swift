//
//  Note.swift
//  Soda
//
//  Created by Derik Flanary on 4/11/19.
//  Copyright © 2019 O.C. Tanner. All rights reserved.
//

import Foundation

struct Note {
    
    let id: Int
    let workOrderId: Int
    let text: String
    let ascLineNumber: Int
    let createdAt: Date?
    
}


extension Note: Codable {
    
    enum CodingKeys: String, CodingKey {
        case id
        case workOrderId = "work_order_id"
        case text
        case ascLineNumber = "asc_line_num"
        case createdAt = "created_at"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        id = try values.decode(Int.self, forKey: .id)
        workOrderId = try values.decode(Int.self, forKey: .workOrderId)
        text = try values.decode(String.self, forKey: .text)
        ascLineNumber = try values.decode(Int.self, forKey: .ascLineNumber)
        let createdAtString = try values.decode(String.self, forKey: .createdAt)
        createdAt = createdAtString.date()
    }
    
}
