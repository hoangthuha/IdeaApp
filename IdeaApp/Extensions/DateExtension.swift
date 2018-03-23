import Foundation

extension Date {
    
    static let formatter = DateFormatter()
    
    func styleDate(style : DateFormaterKey) -> String {
        Date.formatter.dateFormat = style.language()
        Date.formatter.locale = Locale(identifier: Localize.currentLanguage())
        return Date.formatter.string(from: self)
    }

    
    func asString(format:String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = format
        dateFormatter.amSymbol = "AM"
        dateFormatter.pmSymbol = "PM"
        return dateFormatter.string(from: self)
    }
    
    func stringAgo(numericDates: Bool = false) -> String {
        let calendar = Calendar.current
        let now = NSDate()
        let earliest = now.earlierDate(self)
        let latest = earliest == now as Date ? self : now as Date
        let components = calendar.dateComponents([.year, .weekOfYear, .month, .day, .hour, .minute, .second], from: earliest, to: latest as Date)
        
        var result = ""
        
        let yearBefore = "YearBefore".localized() //= "years ago";
        let oneYearBefore = "1YearBefore".localized() //= "1 year ago";
        let lastYear = "LastYear".localized() //= "Last year";
        let monthBefore = "MonthBefore".localized() //= "months ago";
        let oneMonthBefore = "1MonthBefore".localized() //= "1 months ago";
        let lastMonth = "LastMonth".localized() //= "Last month";
        let weekBefore = "WeekBefore".localized() //= "weeks ago";
        let oneWeekBefore = "1WeekBefore".localized() // = "1 weeks ago";
        let lastWeek = "LastWeek".localized() //= "Last week";
        let dayBefore = "DayBefore".localized() //= "days ago";
        let oneDayBefore = "1DayBefore".localized() //= "1 day ago";
        let yesterday = "Yesterday".localized() //= "Yesterday";
        let hourBefore = "HourBefore".localized() //= "hours ago";
        let oneHourBefore = "1HourBefore".localized() //= "1 hour ago";
        let anHourBefore = "AHourBefore".localized() //= "An hour ago";
        let minuteBefore = "MinuteBefore".localized() //= "minutes ago";
        let oneMinuteBefore = "1MinuteBefore".localized() //= "1 minute ago";
        let aMinuteBefore = "AMinuteBefore".localized() //= "A minute ago";
        let secondBefore = "SecondBefore".localized() //= "seconds ago";
        let justNow = "JustNow".localized() //= "Just now";
        
        if components.year! >= 2 {
            result = "\(components.year!) \(yearBefore)"
        } else if components.year! >= 1 {
            if numericDates {
                result = oneYearBefore
            } else {
                result = lastYear
            }
        } else if components.month! >= 2 {
            result = "\(components.month!) \(monthBefore)"
        } else if components.month! >= 1 {
            if numericDates {
                result = oneMonthBefore
            } else {
                result = lastMonth
            }
        } else if components.weekOfYear! >= 2 {
            result = "\(components.weekOfYear!) \(weekBefore)"
        } else if components.weekOfYear! >= 1 {
            if numericDates {
                result = oneWeekBefore
            } else {
                result = lastWeek
            }
        } else if components.day! >= 2 {
            result = "\(components.day!) \(dayBefore)"
        } else if components.day! >= 1 {
            if numericDates {
                result = oneDayBefore
            } else {
                result = yesterday
            }
        } else if components.hour! >= 2 {
            result = "\(components.hour!) \(hourBefore)"
        } else if components.hour! >= 1 {
            if numericDates {
                result = oneHourBefore
            } else {
                result = anHourBefore
            }
        } else if components.minute! >= 2 {
            result = "\(components.minute!) \(minuteBefore)"
        } else if components.minute! >= 1 {
            if numericDates {
                result = oneMinuteBefore
            } else {
                result = aMinuteBefore
            }
        } else if components.second! >= 3 {
            result = "\(components.second!) \(secondBefore)"
        } else {
            result = justNow
        }
        return result
    }
}

extension Date {
    init(isoDateString: String) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        dateFormatter.timeZone = NSTimeZone.local
        let date = dateFormatter.date(from: isoDateString)
        self = date ?? Date()
    }
    
    init(year : Int){
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let string = "\(year)-12-31"
        let date = dateFormatter.date(from: string)!
        self = date
    }
    var year : String{
        let calendar = Calendar(identifier: .gregorian)
        let year = calendar.component(.year, from: self)
        return "\(year)"
    }
    var isoString : String{
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = Locale.init(identifier: Localize.currentLanguage())
        formatter.timeZone = TimeZone(secondsFromGMT: 7)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        return formatter.string(from: self)
        
    }
    var month: String{
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        return "\(month)"
    }
    var day: String{
        let calendar = Calendar(identifier: .gregorian)
        let day = calendar.component(.day, from: self)
        return "\(day)"
    }
    var monthYear: String {
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        return "\(month)/\(year)"
    }
    var dayMonthYear : String{
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let day = calendar.component(.day, from: self)
        return "\(day)/\(month)/\(year)"
    }
    var yearMonthDate : String{
        let calendar = Calendar(identifier: .gregorian)
        let month = calendar.component(.month, from: self)
        let year = calendar.component(.year, from: self)
        let day = calendar.component(.day, from: self)
        return "\(year)/\(month)/\(day)"
    }
    
    var hour : String{
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: self)
        return "\(hour)"
    }
    var minute: String{
        let calendar = Calendar(identifier: .gregorian)
        let minute = calendar.component(.minute, from: self)
        return "\(minute)"
    }
    var second: String{
        let calendar = Calendar(identifier: .gregorian)
        let second = calendar.component(.second, from: self)
        return "\(second)"
    }
    
    var hourMinute: String{
        let formatter = DateFormatter()
        //formatter.locale = Locale(identifier: LanguageManager.shared.getCurrentLanguage().languageCode!)
        formatter.dateFormat = "HH:mm"
        let hourMinute = formatter.string(from: self)
        return hourMinute
    }
    var hourMinuteSecond: String{
        let calendar = Calendar(identifier: .gregorian)
        let hour = calendar.component(.hour, from: self)
        let minute = calendar.component(.minute, from: self)
        let second = calendar.component(.second, from: self)
        return "\(hour)h\(minute)p\(second)"
    }
    
    var rangeDate: DateComponents{
        let toDate = Date()
        let calendar = Calendar.current
        let dateComponents = calendar.dateComponents([.year , .month, .day, .hour, .minute, .second], from: self, to: toDate)
        return dateComponents
    }
    var compareDate: Bool{
        let currentDate = Date()
        switch self.compare(currentDate) {
        case .orderedAscending:
            return true
        case .orderedDescending:
            return false
        default:
            return false
        }
    }
    
    func postDefaultDate() -> Date{
        if Int(self.hour)! >= 22 {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let string = "\(self.year)-\(self.month)-\(self.day)"
            var date = dateFormatter.date(from: string)!
            date = Date(timeInterval: 23 * 60 * 60 + (59 * 60), since: date)
            return date
        }
        let date = Date(timeInterval: 60 * 60 * 2, since: self)
        return date
    }
    
    var periodTime: String{
        let dateComponent = self.rangeDate
        if dateComponent.month! > 0{
            if dateComponent.month == 1{
                return "\((dateComponent.month)!) \("1MonthBefore".localized())"
            }
            return "\((dateComponent.month)!) \("MonthBefore".localized())"
            
        }else if dateComponent.day! > 0{
            if dateComponent.day == 1{
                return "\((dateComponent.day)!) \("1DayBefore".localized())"
            }
            return "\((dateComponent.day)!) \("DayBefore".localized())"
        }else if dateComponent.hour! > 0{
            return "\((dateComponent.hour)!) \("HourBefore".localized())"
        }
        return "\((dateComponent.minute)!) \("MinuteBefore".localized())"
    }
}


extension Date {
    
    var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: noon)!
    }
    var today: Date {
        return Calendar.current.date(byAdding: .day, value: 0, to: noon)!
    }
    var oneWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: noon)!
    }
    var aMonth: Date {
        return Calendar.current.date(byAdding: .day, value: -30, to: noon)!
    }
    var aYear: Date {
        return Calendar.current.date(byAdding: .day, value: -360, to: noon)!
    }
    var noon: Date {
        return Calendar.current.date(bySettingHour: 12, minute: 0, second: 0, of: self)!
    }
    var monthDay: Int {
        return Calendar.current.component(.month,  from: self)
    }
    func getThisMonth() -> Date? {
        let components = Calendar.current.dateComponents([.year, .month], from: self)
        return Calendar.current.date(from: components)!
    }
    
}
