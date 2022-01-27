//
//  StarterViewController.swift
//  Wordle
//
//  Created by Ankur on 22/1/22.
//

import UIKit

class StarterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        performSegue(withIdentifier: "segueToMainGame", sender: self)
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WordleTableViewController {
            destination.viewModel = .init(originalString: WordleManager.shared.selectedWord)
        }
    }


}
