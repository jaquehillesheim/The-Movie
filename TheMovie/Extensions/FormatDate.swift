//
//  FormatDate.swift
//  TheMovie
//
//  Created by Jaqueline Hillesheim on 17/11/22.
//

import Foundation

extension String {
    func formatDate() -> Self {
        let inputFormatter = DateFormatter()
        inputFormatter.dateFormat = "yyyy-MM-dd"
        let showDate = inputFormatter.date(from: self)
        guard let showDate = showDate else {
            return "Não foi possível obter a data"
        }
        
        inputFormatter.dateFormat = "dd/MM/yyyy"
        return inputFormatter.string(from: showDate)
    }
    
}
