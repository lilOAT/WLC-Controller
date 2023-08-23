//
//  APHomeViewController.swift
//  WLC Controller
//
//  Created by Joel Pita on 16/8/2023.
//

import UIKit

class APViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func didTapButton() {
        let vc = storyboard?.instantiateViewController(identifier: "clientlist_vc") as! ClientListViewController
        present(vc, animated: true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
