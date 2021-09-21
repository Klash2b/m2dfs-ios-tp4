//
//  ViewController.swift
//  tp3bis
//
//  Created by MATTEI MATHIEU on 21/09/2021.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var myVar: [String:[[String:String]]] = [:];
    struct myJsonData: Decodable {
        enum Category: String, Decodable {
            case swift, combine, debugging, xcode;
        }
        
        let date: String;
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 1. Initialisation
        tableView = UITableView(frame: self.view.frame);
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        let path = Bundle.main.path(forResource: "scb_resultats", ofType: "json")
        let data:NSData = try! NSData(contentsOfFile: path!);
        
        do {
            myVar = try JSONSerialization.jsonObject(with: data as Data, options: .allowFragments) as! [String:[[String:String]]]
        } catch let error as NSError {
            print(error);
        }
        
        print(myVar["resultats"]![0]["date"]!);
        
        self.view.addSubview(tableView);
        tableView.delegate = self;
        tableView.dataSource = self;
    }
    
    // 1. Initialisation
    var tableView = UITableView(frame: CGRect.zero)
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myVar["resultats"]!.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let innerView = UITableViewCell(frame: CGRect(x: 0, y: (0.10*self.view.frame.maxY + CGFloat(50*indexPath.row)), width: self.view.frame.maxX, height: 60))
        
        let dateLabel = UILabel(frame: CGRect(x: 0.15*self.view.frame.maxX, y: -5, width: 150, height: 40))
        dateLabel.textAlignment = .left;
        dateLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        dateLabel.textColor = UIColor.lightGray;
        dateLabel.text = myVar["resultats"]![indexPath.row]["date"]!
        
        let domLogo = UIImageView();
        domLogo.image = UIImage(named: myVar["resultats"]![indexPath.row]["dom_logo_name"]!)
        domLogo.frame = CGRect(x: 0.05*self.view.frame.maxX, y: 10, width: 40, height: 40)
        domLogo.contentMode = .scaleAspectFit;
        
        let domLabel = UILabel(frame: CGRect(x: 0.15*self.view.frame.maxX, y: 10, width: 150, height: 40))
        domLabel.textAlignment = .left;
        domLabel.text = myVar["resultats"]![indexPath.row]["dom_name"]!
        
        let scoreLabel = UILabel(frame: CGRect(x: 0.35*self.view.frame.maxX, y: 10, width: 150, height: 40))
        scoreLabel.textAlignment = .center;
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 16);
        if(myVar["resultats"]![indexPath.row]["score"] != "") {
            
            scoreLabel.text = myVar["resultats"]![indexPath.row]["score"]!
        } else {
            
            scoreLabel.text = "-"
        }
        
        let extLabel = UILabel(frame: CGRect(x: 0.5*self.view.frame.maxX, y: 10, width: 150, height: 40))
        extLabel.textAlignment = .right;
        extLabel.text = myVar["resultats"]![indexPath.row]["ext_name"]!
        
        let extLogo = UIImageView();
        extLogo.image = UIImage(named: myVar["resultats"]![indexPath.row]["ext_logo_name"]!)
        extLogo.frame = CGRect(x: 0.90*self.view.frame.maxX, y: 10, width: 40, height: 40)
        extLogo.contentMode = .scaleAspectFit;
        
        innerView.addSubview(dateLabel);
        innerView.addSubview(domLogo);
        innerView.addSubview(domLabel);
        innerView.addSubview(scoreLabel);
        innerView.addSubview(extLabel);
        innerView.addSubview(extLogo);
        
        return innerView;
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        print("You selected cell #\(indexPath.row)!")
    }
}
