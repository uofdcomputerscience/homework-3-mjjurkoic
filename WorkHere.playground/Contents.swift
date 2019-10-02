import Foundation
import UIKit
import PlaygroundSupport

PlaygroundPage.current.needsIndefiniteExecution = true

// This homework should be fairly simple.
// visit https://github.com/noops-challenge/wordbot to read
// the documentation for wordbot.
//
// Using that documentation, write a playground that does
// the following:
// download 50 words
// decode those 50 words into an array of strings
// print the array of words, but with each word reversed
// print the average number of characters per word

struct WordList: Codable {
    let words: [String]
    
    // Prints the array of words with each word reversed
    func reverseWords() -> [String] {
        var reversedWords = [String]()
        
        for word in words {
            reversedWords.append(String(word.reversed()))
        }
        return reversedWords
    }
    
    // Prints the average number of characters per word
    func averageLength() -> Int {
        var wordCount: Int = 0
        var wordLengthSum: Int = 0
        
        for word in words {
            wordCount += 1
            wordLengthSum += word.count
        }
        
        return wordLengthSum / wordCount
    }
}

let numWords: Int = 50
let urlString: String = "https://api.noopschallenge.com/wordbot?count=\(numWords)"
if let requestURL = URL(string: urlString) {
    let request = URLRequest(url: requestURL)
    let session = URLSession(configuration: .ephemeral)
    let task = session.dataTask(with: request) { (data, response, error) in
        let wordList = try! JSONDecoder().decode(WordList.self, from: data!)
        print("Reversed words: \(wordList.reverseWords())")
        print("")
        print("Average word length: \(wordList.averageLength())")
    }
    task.resume()
}
