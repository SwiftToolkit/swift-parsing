import Parsing
import Foundation
import ArgumentParser

@main
struct App: ParsableCommand {
    @Argument(help: "Path to Package.swift file")
    var packageFilePath: String
    
    mutating func run() throws {
        let packageContents = try String(contentsOfFile: packageFilePath)
        
        struct Dependency {
            let url: String
            let version: String
            let owner: String
        }
        
        let parameter: some Parser<Substring, String> = Parse {
            Prefix(while: { $0 != #"""#}).map(String.init)
        }
        
        let dependencyLine = Parse(Dependency.init) {
            // note the removal of the first Skip
            Skip {
                ".package(url:"
                Whitespace.init()
                #"""#
            }
            parameter
            Skip {
                #"", exact: ""#
            }
            parameter
            Skip {
                #"", owner: ""#
            }
            parameter
            Skip { // added so we parse until the end of the line
                #"")"#
                Optionally { "," }
            }
        }
        let dependencies = Parse {
            Skip { // moved from the previous parser
                PrefixUpTo(".package")
            }
            Many {
                dependencyLine
            } separator: {
                OneOf {
                    "\n"
                    ",\n"
                }
                PrefixUpTo(".package")
            } terminator: {
                Whitespace()
              "]"
            }
        }
        var input = packageContents[...] // loaded String from the file
        let parsed = try dependencies.parse(&input)
        print("parsed>>\(parsed)<<")
        print("rest>>\(input)<<")
    }
}


