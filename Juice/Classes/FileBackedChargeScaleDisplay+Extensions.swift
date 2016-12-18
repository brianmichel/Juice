//
//  FileBackedChargeScaleDisplay+Extensions.swift
//  Juice
//
//  Created by Brian Michel on 12/17/16.
//  Copyright © 2016 Brian Michel. All rights reserved.
//

import Foundation

extension FileBackedChargeScaleDisplay {
    static func makeApplicationDefaults() -> [FileBackedChargeScaleDisplay] {
        return [
            makeEmojiScale(),
            makeWeirdStringScale(),
            makeASCIIScale(),
            makeRomanNumeralScale()
        ]
    }
    
    static func makeEmojiScale() -> FileBackedChargeScaleDisplay {
        let detents = [1: "☠️",
                       2: "💀",
                       3: "😡",
                       4: "😠",
                       5: "😟",
                       6: "😳",
                       7: "🙄",
                       8: "😏",
                       9: "☺️",
                       10: "😁"]
        
        return FileBackedChargeScaleDisplay(title: "Emoji Faces",
                                            detents: detents,
                                            defaultDetentString: "😰",
                                            fileName: "emoji-faces")
    }
    
    static func makeWeirdStringScale() -> FileBackedChargeScaleDisplay {
        let detents = [1: "ded bruv",
                       2: "dyin'",
                       3: "💀 soon",
                       4: "plz charge",
                       5: "half way",
                       6: "about half",
                       7: "about a C",
                       8: "good",
                       9: "great!!",
                       10: "i'm full"]
        
        return FileBackedChargeScaleDisplay(title: "Weird Text (Clean)",
                                            detents: detents,
                                            defaultDetentString: "uhh...",
                                            fileName: "weird-text-clean")
    }
    
    static func makeASCIIScale() -> FileBackedChargeScaleDisplay {
        let detents = [1: "├┃         ┤",
                       2: "├┃┃        ┤",
                       3: "├┃┃┃       ┤",
                       4: "├┃┃┃┃      ┤",
                       5: "├┃┃┃┃┃     ┤",
                       6: "├┃┃┃┃┃┃    ┤",
                       7: "├┃┃┃┃┃┃┃   ┤",
                       8: "├┃┃┃┃┃┃┃┃  ┤",
                       9: "├┃┃┃┃┃┃┃┃┃ ┤",
                       10:"├┃┃┃┃┃┃┃┃┃┃┤"]
        
        return FileBackedChargeScaleDisplay(title: "ASCII Battery",
                                            detents: detents,
                                            defaultDetentString: "├    ??   ┤",
                                            fileName: "ascii-battery")
    }
    
    static func makeRomanNumeralScale() -> FileBackedChargeScaleDisplay {
        let detents = [1: "Ⅰ",
                       2: "Ⅱ",
                       3: "Ⅲ",
                       4: "Ⅳ",
                       5: "Ⅴ",
                       6: "Ⅵ",
                       7: "Ⅶ",
                       8: "Ⅷ",
                       9: "Ⅸ",
                       10: "Ⅹ"]
        
        return FileBackedChargeScaleDisplay(title: "Roman Numerals",
                                            detents: detents,
                                            defaultDetentString: "et tu?",
                                            fileName: "roman-numerals")
    }
}
