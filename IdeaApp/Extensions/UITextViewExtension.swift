import UIKit

extension UITextView: UITextViewDelegate {
    
    var textViewPlaceholderLabel: UILabel? {
        set {} get {
            return self.viewWithTag(100) as? UILabel
        }
    }
    
    // Placeholder text
    var textViewPlaceholder: String? {
        
        get {
            // Get the placeholder text from the label
            var placeholderText: String?
            
            if let placeHolderLabel = self.viewWithTag(100) as? UILabel {
                placeholderText = placeHolderLabel.text
            }
            return placeholderText
        }
        
        set {
            // Store the placeholder text in the label
            let placeHolderLabel = self.viewWithTag(100) as! UILabel?
            if placeHolderLabel == nil {
                // Add placeholder label to text view
                self.addPlaceholderLabel(newValue!)
            }
            else {
                placeHolderLabel?.text = newValue
                placeHolderLabel?.sizeToFit()
            }
        }
    }
    
    // Hide the placeholder label if there is no text
    // in the text viewotherwise, show the label
    public func textViewDidChange(_ textView: UITextView) {
//        print(textView)
        let placeHolderLabel = self.viewWithTag(100)
        
        if !self.hasText {
            // Get the placeholder label
            placeHolderLabel?.isHidden = false
        }
        else {
            placeHolderLabel?.isHidden = true
        }
    }
    
    // Add a placeholder label to the text view
    func addPlaceholderLabel(_ placeholderText: String) {
        
        // Create the label and set its properties
        let placeholderLabel = UILabel()
        placeholderLabel.text = placeholderText
        placeholderLabel.sizeToFit()
        placeholderLabel.frame.origin.x = 5.0
        placeholderLabel.frame.origin.y = 5.0
        placeholderLabel.font = self.font
        placeholderLabel.textColor = UIColor.color(0xC7C7CD)
        placeholderLabel.tag = 100
        
        // Hide the label if there is text in the text view
        if self.text.count > 0 {
            placeholderLabel.isHidden = true
        }
        
        self.addSubview(placeholderLabel)
        //self.delegate = self
    }
    
}
