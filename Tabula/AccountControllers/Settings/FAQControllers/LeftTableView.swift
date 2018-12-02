//
//  LeftTableView.swift
//  Tabula
//
//  Created by Adi Veliman on 01/12/2018.
//  Copyright © 2018 Adi Veliman. All rights reserved.
//

import UIKit

class LeftTableView: UITableViewController {

    var sir = ["Getting started","Vouchers"]
    var intrebari = ["Cum se foloseste aplicatia?","Cum se foloseste aplicatia?","Cum se foloseste aplicatia?","Cum se foloseste aplicatia?"]
    var raspunsuri = ["Aplicatia se bazeaza pe un sistem de vouchere! etc.etc.etc.etc.etc.etc.etc.etc.etc"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.contentInsetAdjustmentBehavior = .never
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
        
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return sir.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return intrebari.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customFAQ", for: indexPath) as! CustomFAQCell
        
        cell.questionLabel.text = intrebari[indexPath.row]
        cell.answerView.text = cell.selection ? "View answer >" : raspunsuri[0]
        cell.answerView.textColor = cell.selection ? UIColor.orange : UIColor.gray
        
        // Configure the cell...
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        //cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1)
        cell.transform = CGAffineTransform(translationX: cell.frame.origin.x - 400, y: cell.bounds.origin.y)
        
        
        UIView.animate(withDuration: 0.6, animations: {
            //cell.layer.transform = CATransform3DMakeScale(1.0, 1.0, 1.0)
            cell.transform = .identity
        }, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CustomFAQCell
        cell.selection = !cell.selection
        
        cell.answerView.text = cell.selection ? "View answer >" : raspunsuri[0]
        cell.answerView.textColor = cell.selection ? UIColor.orange : UIColor.gray
        tableView.beginUpdates()
        tableView.endUpdates()
        
        
        
    }
    
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sir[section]
    }
    
    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let view = view as! UITableViewHeaderFooterView
        view.contentView.backgroundColor = UIColor(hex: "1e1e15")
        view.textLabel?.textColor = UIColor.white
        
    }
    

}
