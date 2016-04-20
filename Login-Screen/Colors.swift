//
//  Colors.swift
//  Login
//
//  Created by Zach Ambur on 4/11/16.
//  Copyright © 2016 Zach Ambur. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    class func colorArray() -> Array<UIColor> {
        let colors: [UIColor] = [color1(), color2(), color3(), color4(), color5(),
                                 color6(), color7(), color8(), color9(), color10(),
                                 color11(), color12(), color13(), color14(), color15(),
                                 color16(), color17(), color18(), color19(), color20()]
        return colors
    }
    
    class func color1() -> UIColor {
        return UIColor(red: 204/255, green: 92/255, blue: 244/255, alpha: 1)
    }
    
    class func color2() -> UIColor {
        return UIColor(red: 187/255, green: 98/255, blue: 241/255, alpha: 1)
    }
    
    class func color3() -> UIColor {
        return UIColor(red: 170/255, green: 105/255, blue: 238/255, alpha: 1)
    }
    
    class func color4() -> UIColor {
        return UIColor(red: 150/255, green: 112/255, blue: 235/255, alpha: 1)
    }
    
    class func color5() -> UIColor {
        return UIColor(red: 134/255, green: 118/255, blue: 232/255, alpha: 1)
    }
    
    class func color6() -> UIColor {
        return UIColor(red: 116/255, green: 124/255, blue: 229/255, alpha: 1)
    }
    
    class func color7() -> UIColor {
        return UIColor(red: 100/255, green: 130/255, blue: 226/255, alpha: 1)
    }
    
    class func color8() -> UIColor {
        return UIColor(red: 81/255, green: 137/255, blue: 223/255, alpha: 1)
    }
    
    class func color9() -> UIColor {
        return UIColor(red: 74/255, green: 140/255, blue: 222/255, alpha: 1)
    }
    
    class func color10() -> UIColor {
        return UIColor(red: 64/255, green: 144/255, blue: 220/255, alpha: 1)
    }
    
    class func color11() -> UIColor {
        return UIColor(red: 44/255, green: 152/255, blue: 217/255, alpha: 1)
    }
    
    class func color12() -> UIColor {
        return UIColor(red: 36/255, green: 166/255, blue: 213/255, alpha: 1)
    }
    
    class func color13() -> UIColor {
        return UIColor(red: 33/255, green: 172/255, blue: 212/255, alpha: 1)
    }
    
    class func color14() -> UIColor {
        return UIColor(red: 26/255, green: 185/255, blue: 209/255, alpha: 1)
    }
    
    class func color15() -> UIColor {
        return UIColor(red: 22/255, green: 192/255, blue: 206/255, alpha: 1)
    }
    
    class func color16() -> UIColor {
        return UIColor(red: 20/255, green: 196/255, blue: 206/255, alpha: 1)
    }
    
    class func color17() -> UIColor {
        return UIColor(red: 16/255, green: 203/255, blue: 204/255, alpha: 1)
    }
    
    class func color18() -> UIColor {
        return UIColor(red: 12/255, green: 210/255, blue: 203/255, alpha: 1)
    }
    
    class func color19() -> UIColor {
        return UIColor(red: 9/255, green: 216/255, blue: 201/255, alpha: 1)
    }
    
    class func color20() -> UIColor {
        return UIColor(red: 1/255, green: 231/255, blue: 197/255, alpha: 1)
    }
}

