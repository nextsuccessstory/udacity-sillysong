//
//  ViewController.swift
//  Silly Song
//
//  Created by Casa Gunnar on 11/7/17.
//  Copyright © 2017 Next Success Story, LLC. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var lyricsView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nameField.delegate = self
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func reset(_ sender: Any) {
        nameField.text = ""
    }
    
    @IBAction func displayLyrics(_ sender: Any) {
        let bananaFanaTemplate = [
            "<FULL_NAME>, <FULL_NAME>, Bo B<SHORT_NAME>",
            "Banana Fana Fo F<SHORT_NAME>",
            "Me My Mo M<SHORT_NAME>",
            "<FULL_NAME>"].joined(separator: "\n")
        
        if nameField.hasText {
            var firstname = nameField.text!
            firstname = firstname.prefix(1).capitalized + firstname.dropFirst()
            nameField.text = firstname
            let lyrics = lyricsForName(lyricsTemplate: bananaFanaTemplate, fullname: nameField.text!)
            lyricsView.text = lyrics
        }
    }
    
    
}

extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
}

func shortNameFromName(name: String) -> String {
    var lowercaseName = name.lowercased()
    let vowels = CharacterSet(charactersIn: "aeiou")
    let range = lowercaseName.rangeOfCharacter(from: vowels)
    
    lowercaseName = String(lowercaseName.characters.suffix(from: range!.lowerBound))
    
    return lowercaseName
}

func lyricsForName(lyricsTemplate: String, fullname: String) -> String {
    var lyrics = lyricsTemplate
    let shortName = shortNameFromName(name: fullname)
    
    lyrics = lyrics
        .replacingOccurrences(of: "<FULL_NAME>", with: fullname)
        .replacingOccurrences(of: "<SHORT_NAME>", with: shortName)
    
    return lyrics
}

