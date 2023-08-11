//
//  String++.swift
//  NewsApp
//
//  Created by Kavindu Dissanayake on 2023-08-11.
//

import UIKit


extension String{

    func widthWithConstrainedHeight(_ height: CGFloat, font: UIFont) -> CGFloat {
        let constraintRect = CGSize(width: CGFloat.greatestFiniteMagnitude, height: height)

        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)

        return ceil(boundingBox.width)
    }

    func heightWithConstrainedWidth(_ width: CGFloat, font: UIFont) -> CGFloat? {
        let constraintRect = CGSize(width: width, height: CGFloat.greatestFiniteMagnitude)
        let boundingBox = self.boundingRect(with: constraintRect, options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: [NSAttributedString.Key.font: font], context: nil)
        return ceil(boundingBox.height)
    }

}
extension String {
    
    enum DateFormats: String{
        case dateformatLong = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        case dateformatLong2 = "yyyy-MM-dd'T'HH:mm:ss'Z'"
        case dateformatLong3 = "yyyy-MM-dd'T'HH:mm:SSS'Z'"
        case dateformatBig = "yyyy-MM-dd'T'HH:mm:ss.SSS"
        case dateformatBig2 = "yyyy-MM-dd'T'HH:mm:ss"
        case dateformatYMD = "yyyy-MM-dd"
        case dateformatYMDHMS = "yyyy-MM-dd HH:mm:ss"
        case dateformatYMDHM = "yyyy-MM-dd HH:mm"
        case dateformatDMY = "dd MMM yyyy"
        case dateformatDMYHMA = "dd-MMM-yyyy '|' hh:mm a"
        case dateformatDMYHMASpace = "dd MMM yyyy '|' hh:mm a"
        case dateformatEDMMM = "E, d MMM"
        case dateformateMMMDD = "MMM dd"
        case dateformateHHMM = "HH:mm"
        case dateformateHHMMA = "HH:mm a"
        case dateformatehmma = "hh:mm a"
        case dateformateMMMDDYYY = "MMM dd, yyyy"
        case dateformatDMY2 = "dd/MM/yyyy"
        case dateformatD = "dd"
        case dateformatM = "MM"
        case dateformatY = "yyyy"
        case dateformatHH = "HH"
        case dateformathh = "hh"
        case dateformatMM = "mm"
        case dateformatA = "a"
        case dateformatDD_MM_YY = "MM/dd/yyyy H:mm:ss"
        case dateformateHMSZ = "HH:mm:ss.SSS"
        case dateformatYDMHMA = "yyyy-MMM-dd '|' hh:mm a"
        case dateformatYDMHMA2 = "yyyy-MMM-dd hh:mm a"
        case dateformatMDYHMA2 = "MMM dd yyyy - hh:mm a"
        
        static var commonApiFormats: [DateFormats] = [
                   .dateformatLong, .dateformatLong2, .dateformatLong3, .dateformatYMDHMS, .dateformatDD_MM_YY
               ]
    }
    
    

    func toDate(with format: DateFormats, locale: String = "en_US_POSIX") -> Date? {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
    
    func convertToDate(format: DateFormats, locale: String = "en_US_POSIX") -> String {
        for apiFormat in DateFormats.commonApiFormats {
            if let date = self.toDate(with: apiFormat) {
                return date.toString(format: format, locale: locale)
            }
        }
        return ""
    }
}

extension Date {
    func toString(format: String.DateFormats, locale: String = "en_US_POSIX") -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: locale)
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
