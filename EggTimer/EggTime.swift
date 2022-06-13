import Foundation
import SwiftUI

enum EggTime: String {
    case soft = "Soft"
    case medium = "Medium"
    case hard = "Hard"
    
    var eggImage: String {
        
        switch self {
        case .soft:
       return  "soft_egg"
        case .medium:
            return "medium_egg"
        case .hard:
            return "hard_egg"
        }
    }
    

}
