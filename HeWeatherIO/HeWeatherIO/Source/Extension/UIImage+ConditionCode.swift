//
//  UIImage+ConditionCode.swift
//  HeWeatherIO
//
//  Created by iMac on 2018/5/25.
//  Copyright © 2018年 iMac. All rights reserved.
//

import Foundation

extension UIImage {
    class func conditionImage(icon: ConditionCode, completionHandler: @escaping (UIImage?) -> Void) {
        DispatchQueue.global(qos: .default).async {

            var image: UIImage?
            do {
                let data = try Data(contentsOf: UIImage.localImagePath(icon: icon)!)
                image = UIImage(data: data)
            } catch {

                do {
                    let data = try Data(contentsOf: UIImage.remoteImagePath(icon: icon)!)
                    image = UIImage(data: data)

                    let fileManager = FileManager.default
                    fileManager.createFile(atPath: UIImage.localImagePath(icon: icon),
                                           contents: data,
                                           attributes: nil)
                } catch { }
            }

            image = image?.imageWithColor(color: UIColor.white)

            DispatchQueue.main.async {
                completionHandler(image)
            }
        }
    }

    private class func remoteImagePath(icon: ConditionCode) -> URL? {
        return URL(string: "https://cdn.heweather.com/cond_icon/\(icon.rawValue).png")
    }

    private class func localImagePath(icon: ConditionCode) -> String {

        let myPathes = NSSearchPathForDirectoriesInDomains(.documentDirectory,
                                                           .userDomainMask,
                                                           true)
        let docPath = myPathes[0]
        return NSString(string: docPath).appendingPathComponent("/conditionImage/\(icon.rawValue).png") as String
    }

    private class func localImagePath(icon: ConditionCode) -> URL? {
        return URL(string: UIImage.localImagePath(icon: icon))
    }

    private func imageWithColor(color: UIColor) -> UIImage? {

        guard let cgImage = self.cgImage else {
            return nil
        }

        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
        defer {
            UIGraphicsEndImageContext()
        }
        let context = UIGraphicsGetCurrentContext()
        context?.translateBy(x: 0, y: self.size.height)
        context?.scaleBy(x: 1.0, y: -1.0)
        context?.setBlendMode(.normal)
        let rect = CGRect(x: 0.0, y: 0.0, width: self.size.width, height: self.size.height)
        context?.clip(to: rect, mask: cgImage)
        color.setFill()
        context?.fill(rect)

        return UIGraphicsGetImageFromCurrentImageContext()
    }
}
