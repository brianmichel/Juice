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
            makeRomanNumeralScale(),
            makeHorizontalLineScale()
        ]
    }
    
    static func makeEmojiScale() -> FileBackedChargeScaleDisplay {
        let detents = [0: "☠️",
                       1: "💀",
                       2: "😡",
                       3: "😠",
                       4: "😟",
                       5: "😳",
                       6: "🙄",
                       7: "😏",
                       8: "☺️",
                       9: "😁"]
        
        return FileBackedChargeScaleDisplay(title: "Emoji Faces",
                                            detents: detents,
                                            defaultDetentString: "😰",
                                            fileName: "emoji-faces")
    }
    
    static func makeWeirdStringScale() -> FileBackedChargeScaleDisplay {
        let detents = [0: "ded bruv",
                       1: "dyin'",
                       2: "💀 soon",
                       3: "plz charge",
                       4: "half way",
                       5: "about half",
                       6: "about a C",
                       7: "good",
                       8: "great!!",
                       9: "i'm full"]
        
        return FileBackedChargeScaleDisplay(title: "Weird Text (Clean)",
                                            detents: detents,
                                            defaultDetentString: "uhh...",
                                            fileName: "weird-text-clean")
    }
    
    static func makeASCIIScale() -> FileBackedChargeScaleDisplay {
        let detents = [0: "├┃         ┤",
                       1: "├┃┃        ┤",
                       2: "├┃┃┃       ┤",
                       3: "├┃┃┃┃      ┤",
                       4: "├┃┃┃┃┃     ┤",
                       5: "├┃┃┃┃┃┃    ┤",
                       6: "├┃┃┃┃┃┃┃   ┤",
                       7: "├┃┃┃┃┃┃┃┃  ┤",
                       8: "├┃┃┃┃┃┃┃┃┃ ┤",
                       9: "├┃┃┃┃┃┃┃┃┃┃┤"]
        
        return FileBackedChargeScaleDisplay(title: "ASCII Battery",
                                            detents: detents,
                                            defaultDetentString: "├    ??   ┤",
                                            fileName: "ascii-battery")
    }
    
    static func makeRomanNumeralScale() -> FileBackedChargeScaleDisplay {
        let detents = [0: "Ⅰ",
                       1: "Ⅱ",
                       2: "Ⅲ",
                       3: "Ⅳ",
                       4: "Ⅴ",
                       5: "Ⅵ",
                       6: "Ⅶ",
                       7: "Ⅷ",
                       8: "Ⅸ",
                       9: "Ⅹ"]
        
        return FileBackedChargeScaleDisplay(title: "Roman Numerals",
                                            detents: detents,
                                            defaultDetentString: "et tu?",
                                            fileName: "roman-numerals")
    }
    
    static func makeHorizontalLineScale() -> FileBackedChargeScaleDisplay {
        let detents = [0: "━┅┅┅┅┅┅┅┅┅",
                       1: "━━┅┅┅┅┅┅┅┅",
                       2: "━━━┅┅┅┅┅┅┅",
                       3: "━━━━┅┅┅┅┅┅",
                       4: "━━━━━┅┅┅┅┅",
                       5: "━━━━━━┅┅┅┅",
                       6: "━━━━━━━┅┅┅",
                       7: "━━━━━━━━┅┅",
                       8: "━━━━━━━━━┅",
                       9: "━━━━━━━━━━"]
        
        return FileBackedChargeScaleDisplay(title: "Dotted Line",
                                            detents: detents,
                                            defaultDetentString: "┅┅┅┅┅┅┅┅┅┅┅",
                                            fileName: "dotted-line")
    }
}
