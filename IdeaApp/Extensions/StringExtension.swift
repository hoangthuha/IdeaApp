import Foundation

extension String {
    subscript(value: PartialRangeUpTo<Int>) -> Substring {
        get {
            return self[..<index(startIndex, offsetBy: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeThrough<Int>) -> Substring {
        get {
            return self[...index(startIndex, offsetBy: value.upperBound)]
        }
    }
    
    subscript(value: PartialRangeFrom<Int>) -> Substring {
        get {
            return self[index(startIndex, offsetBy: value.lowerBound)...]
        }
    }
    
    func trim(to maximumCharacters: Int) -> String {
        let string = String(describing: index(startIndex, offsetBy: maximumCharacters))
        return string
//        return substring(to: index(startIndex, offsetBy: maximumCharacters)) + "..."
    }
    
    func trim(count: Int) -> String {
        let newStr = String(self[..<count]) // Swift 4
        return newStr
    }
    
    
    func heightForWithFont(_ font: UIFont, width: CGFloat, insets: UIEdgeInsets) -> CGFloat {
        let label:UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: width + insets.left + insets.right, height: CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = self
        
        label.sizeToFit()
        return label.frame.height + insets.top + insets.bottom
    }
    
    func estimateFrameForText(_ font: UIFont, width: CGFloat) -> CGRect {
        let size = CGSize(width: width, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        return NSString(string: self).boundingRect(with: size, options: options, attributes: [NSAttributedStringKey.font: font], context: nil)
    }

    func isEmptyOrWhitespace() -> Bool {
        if(self.isEmpty) { return true }
        return (self.trimmingCharacters(in: CharacterSet.whitespaces) == "")
    }
    
    func timeIntervalToMMSSFormat() -> String {
        let ti = Int(self)
        let seconds = ti! % 60
        let minutes = (ti! / 60) % 60
        let hour = (ti! / 60) / 60
        if hour == 0 {
            return String(format: "%02ld:%02ld", Int(minutes), Int(seconds))
        }
        return String(format: "%02ld:%02ld:%02ld", Int(hour), Int(minutes), Int(seconds))
    }
    
    
    func timeFormatDuration(_ duration: Int) -> String {
        let ti = Int(duration)
        let seconds = ti % 60
        let minutes = (ti / 60) % 60
        return String(format: "%02ld:%02ld", Int(minutes), Int(seconds))
    }
    
    func toDateTime(_ dateFormat: String = "yyyy-MM-dd'T'HH:mm:ss'.'SSS") -> Date {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        
        //Specify Format of String to Parse
        dateFormatter.dateFormat = dateFormat
        //Parse into NSDate
        let dateFromString : Date? = dateFormatter.date(from: self)
        
        //Return Parsed Date
        return dateFromString ?? Date()
    }
    
    func toDateTimeWithTimeZone(dateFormat: String, timeZone : TimeZoneHelper = .local) -> Date
 {
        //Create Date Formatter
        let dateFormatter = DateFormatter()
        let zone: Foundation.TimeZone
        //Specify Format of String to Parse
        dateFormatter.dateFormat = dateFormat
        switch timeZone {
        case .local:
            zone = TimeZone.current
        case .utc:
            zone = Foundation.TimeZone(secondsFromGMT: 0)!
        }
        dateFormatter.timeZone = zone
        let locale = Locale(identifier: "en_GB")
        
        dateFormatter.locale = locale
        //Parse into NSDate
        let dateFromString : Date? = dateFormatter.date(from: self)
        
        //Return Parsed Date
        return dateFromString!
    }
}

extension String {
    func split(regex pattern: String) -> [String] {
        guard let re = try? NSRegularExpression(pattern: pattern, options: []) else { return [] }
        
        let nsString = self as NSString // needed for range compatibility
        let stop = "<SomeStringThatYouDoNotExpectToOccurInSelf>"
        let modifiedString = re.stringByReplacingMatches(
            in: self,
            options: [],
            range: NSRange(location: 0, length: nsString.length),
            withTemplate: stop)
        return modifiedString.components(separatedBy: stop)
    }
    
    func htmlAttributedString(completion: ((_ string : NSAttributedString?)->())) {
        if let htmlData = self.data(using: String.Encoding(rawValue: String.Encoding.unicode.rawValue)){
            let attributedString = try! NSAttributedString(data: htmlData, options: [.documentType: NSAttributedString.DocumentType.html], documentAttributes: nil)
            completion(attributedString)
        }else{
            completion(nil)
        }
    }
}

extension String {
    var byWords: [String] {
        var result:[String] = []
        enumerateSubstrings(in: startIndex..<endIndex, options: .byWords) {
            guard let word = $0 else { return }
            print($1,$2,$3)
            result.append(word)
        }
        return result
    }
    var lastWord: String {
        return byWords.last ?? ""
    }
    func lastWords(_ max: Int) -> [String] {
        return Array(byWords.suffix(max))
    }
}

extension String {
    func capturedGroups(withRegex pattern: String) -> [String] {
        var results = [String]()
        
        var regex: NSRegularExpression
        do {
            regex = try NSRegularExpression(pattern: pattern, options: [])
        } catch {
            return results
        }
        
        let matches = regex.matches(in: self, options: [], range: NSRange(location:0, length: self.characters.count))
        
        guard let match = matches.first else { return results }
        
        let lastRangeIndex = match.numberOfRanges - 1
        guard lastRangeIndex >= 1 else { return results }
        
        for i in 1...lastRangeIndex {
            let capturedGroupIndex = match.range(at: i)
            let matchedString = (self as NSString).substring(with: capturedGroupIndex)
            results.append(matchedString)
        }
        
        return results
    }
    
    
}

extension String {
    func index(of string: String, options: CompareOptions = .literal) -> Index? {
        return range(of: string, options: options)?.lowerBound
    }
    func indexes(of string: String, options: CompareOptions = .literal) -> [Index] {
        var result: [Index] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range.lowerBound)
            start = range.upperBound
        }
        return result
    }
    func ranges(of string: String, options: CompareOptions = .literal) -> [Range<Index>] {
        var result: [Range<Index>] = []
        var start = startIndex
        while let range = range(of: string, options: options, range: start..<endIndex) {
            result.append(range)
            start = range.upperBound
        }
        return result
    }
}

extension String {
    
    var doubleValue: Double? {
        return Double(self)
    }
    
    var formatMoney: String {
        let number = NSDecimalNumber(string: self)
        let numberFormatter = NumberFormatter()
        numberFormatter.currencyGroupingSeparator = "."
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.numberStyle = .decimal
        let result = numberFormatter.string(from: number)
        
        return result!
    }
    
}

public extension DispatchQueue {
    
    private static var _onceTracker = [String]()
    
    /**
     Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
     only execute the code once even in the presence of multithreaded calls.
     
     - parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
     - parameter block: Block to execute once
     */
    public class func once(token: String, block:() -> ()) {
        objc_sync_enter(self); defer { objc_sync_exit(self) }
        
        if _onceTracker.contains(token) {
            return
        }
        
        _onceTracker.append(token)
        block()
    }
}

