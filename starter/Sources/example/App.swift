import Parsing
import Foundation
import ArgumentParser

@main
struct App: ParsableCommand {
    @Argument(help: "Path to Package.swift file")
    var packageFilePath: String
    
    mutating func run() throws {
        let packageContents = try String(contentsOfFile: packageFilePath)
        
        let dependencyLine = Parse {
            ""
        }
        var input = packageContents[...] // loaded String from the file
        let parsed = try dependencyLine.parse(&input)
        print("parsed>>\(parsed)<<")
        print("rest>>\(input)<<")
    }
}


