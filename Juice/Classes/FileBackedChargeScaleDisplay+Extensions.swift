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
                       4: "half way-ish",
                       5: "about half",
                       6: "mediocre",
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
    
    static func makeNewScaleTemplateScale(id: String) -> FileBackedChargeScaleDisplay {
        let detents = [0: "Edit Me, I'll be triggered from 0 to 10%",
                       1: "Edit Me, I'll be triggered from 10 to 20%",
                       2: "Edit Me, I'll be triggered from 20 to 30%",
                       3: "Edit Me, I'll be triggered from 30 to 40%",
                       4: "Edit Me, I'll be triggered from 40 to 50%",
                       5: "Edit Me, I'll be triggered from 50 to 60%",
                       6: "Edit Me, I'll be triggered from 60 to 70%",
                       7: "Edit Me, I'll be triggered from 70 to 80%",
                       8: "Edit Me, I'll be triggered from 80 to 90%",
                       9: "Edit Me, I'll be triggered from 90 to 100%"]
        
        return FileBackedChargeScaleDisplay(title: "Edit The Title",
                                            detents: detents,
                                            defaultDetentString: "Edit The Default Value To Show",
                                            fileName: id)
    }
}
