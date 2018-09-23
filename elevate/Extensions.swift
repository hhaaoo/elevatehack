import UIKit

extension UIColor {
    static var lightBlue: UIColor {
        let red: CGFloat = 87
        let green: CGFloat = 198
        let blue: CGFloat = 237
        let alpha: CGFloat = 1

        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: alpha)
    }
}

extension UIImageView {
    func setupDefault() {
        self.layer.cornerRadius = 5.0
        self.contentMode = .scaleAspectFit
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 5.0
        self.layer.masksToBounds = false
        self.layer.shadowOffset = CGSize(width: 1, height: 1)
        self.layer.shadowOpacity = 0.5
    }
}

extension Dictionary {
    var queryParameters: String {
        var parts: [String] = []
        for (key, value) in self {
            let part = String(format: "%@=%@",
                              String(describing: key).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!,
                              String(describing: value).addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)
            parts.append(part as String)
        }
        return parts.joined(separator: "&")
    }
}
