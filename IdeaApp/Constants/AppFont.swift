enum FontSize: Int {
    case h9 = 9
    case h12 = 12
    case h13 = 13
    case h14 = 14
    case h15 = 15
    case h16 = 16
    case h17 = 17
    case h18 = 18
    case h19 = 19
    case h20 = 20
    case h22 = 22
    case h24 = 24
    case h26 = 26
    case h28 = 28
    case h34 = 34
    case h40 = 40
}

enum AppFont: String {
	case regular = "SFUIText-Regular"
	case light = "SFUIText-Light"
    case lightItalic = "SFUIText-LightItalic"
    case medium = "SFUIText-Medium"
    case mediumItalic = "SFUIText-MediumItalic"
    case black = "SFUIText-Black"
    case semibold = "SFUIText-Semibold"
    case bold = "SFUIText-Bold"
    case italic = "SFUIText-Italic"
    case heavy = "SFUIText-Heavy"
    
    func size(_ size: FontSize) -> UIFont {
        let resize = CGFloat(size.rawValue)
        return UIFont(name: self.rawValue, size: resize) ?? UIFont.systemFont(ofSize: resize)
    }
    
}
