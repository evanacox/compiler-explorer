//======---------------------------------------------------------------======//
// Copyright (c) 2022 Evan Cox. All rights reserved.                         //
//                                                                           //
// Licensed under the Apache License, Version 2.0 (the "License");           //
// you may not use this file except in compliance with the License.          //
// You may obtain a copy of the License at                                   //
//                                                                           //
//     http://www.apache.org/licenses/LICENSE-2.0                            //
//                                                                           //
// Unless required by applicable law or agreed to in writing, software       //
// distributed under the License is distributed on an "AS IS" BASIS,         //
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  //
// See the License for the specific language governing permissions and       //
// limitations under the License.                                            //
//======---------------------------------------------------------------======//

import Foundation
import System

/// Models the architecture that a particular compiler is targeting by default
enum Architecture: String, Codable {
    /// 32-bit ARM target
    case arm32 = "arm32"
    /// 64-bit ARM target
    case arm64 = "arm64"
    /// 64-bit x86 target
    case x86_64 = "x86_64"
    /// 32-bit x86 target
    case x86 = "x86"
}

/// Models a compiler version, dealing with all of the oddities that versions follow
///
/// Can contain any string-ified version, and also holds a way to order them
struct Version: Codable {
    /// Gives the human-readable version of a compiler. Ex: `"13.0.1"` or `"trunk"`
    ///
    /// This is what should be displayed to users, but it's not necessarily in any particular format.
    var humanReadable: String
    
    /// This is a version number that can be used for ordering the compilers from one specific vendor
    /// if (and only if) there are multiple of them. There are no constraints on these values, they only need
    /// to lead to the compilers of the same vendor being ordered as desired.
    ///
    /// If it isn't present, it is assumed that either order doesn't matter or that there is only one compiler from this vendor.
    var version: Optional<Int>
}

struct Compiler: Codable, Identifiable {
    /// A human-readable name for the compiler, e.g `"Apple Clang"` or `"llc"`.
    var name: String
    /// The architecture that the compiler (with the default invoker pattern specified) is outputting
    var defaultArch: Architecture
    /// A path to the compiler's executable
    var path: FilePath
    /// The version of the compiler being used
    var version: Version
    /// A pattern for how to invoke the compiler and get back out assembly of the default architecture
    var invokePattern: String
    
    var id: String {
        get {
            self.name
        }
    }
}
