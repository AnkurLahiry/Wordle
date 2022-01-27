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
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
    
    func showPrepareAlert() {
        let alertController = UIAlertController(title: "Please wait!", message: "Please wait sometimes to generate a random word for you", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    
    @IBAction func startTapped(_ sender: UIButton) {
        WordleManager.shared.selectRandomWord(completion: { success in
            if success {
                self.performSegue(withIdentifier: "segueToMainGame", sender: self)
            } else {
                self.showPrepareAlert()
            }
        })
        
    }
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? WordleTableViewController {
            destination.viewModel = .init(originalString: WordleManager.shared.selectedWord)
        }
    }


}
