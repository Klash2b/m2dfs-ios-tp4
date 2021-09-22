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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let innerView = UITableViewCell(frame: CGRect(x: 0, y: (0.10*self.view.frame.maxY + CGFloat(50*indexPath.row)), width: self.view.frame.maxX, height: 50))
        
        let dateLabel = UILabel(frame: CGRect(x: 10, y: 2.5, width: 150, height: 40))
        dateLabel.textAlignment = .left;
        dateLabel.font = UIFont.boldSystemFont(ofSize: 10.0)
        dateLabel.textColor = UIColor.lightGray;
        dateLabel.text = myVar["resultats"]![indexPath.row]["date"]!
        dateLabel.sizeToFit();
        //dateLabel.backgroundColor = .gray;
        dateLabel.autoresizingMask = [.flexibleBottomMargin, .flexibleRightMargin]
        
        let domLogo = UIImageView();
        domLogo.image = UIImage(named: myVar["resultats"]![indexPath.row]["dom_logo_name"]!)
        domLogo.frame = CGRect(x: 0, y: dateLabel.frame.height, width: 40, height: 40)
        domLogo.contentMode = .scaleAspectFit;
        //domLogo.backgroundColor = .green;
        domLogo.autoresizingMask = [.flexibleRightMargin]
        
        let domLabel = UILabel(frame: CGRect(x: domLogo.frame.width, y: dateLabel.frame.height, width: 150, height: 40))
        domLabel.textAlignment = .left;
        //domLabel.backgroundColor = .blue;
        domLabel.text = myVar["resultats"]![indexPath.row]["dom_name"]!
        domLabel.autoresizingMask = [.flexibleWidth, .flexibleRightMargin]
        
        let scoreLabel = UILabel(frame: CGRect(x: domLabel.frame.width, y: dateLabel.frame.height, width: 30, height: 40))
        scoreLabel.textAlignment = .center;
        //scoreLabel.backgroundColor = .red;
        scoreLabel.font = UIFont.boldSystemFont(ofSize: 16);
        scoreLabel.autoresizingMask = [.flexibleWidth, .flexibleLeftMargin, .flexibleRightMargin]
        
        if(myVar["resultats"]![indexPath.row]["score"] != "") {
            
            scoreLabel.text = myVar["resultats"]![indexPath.row]["score"]!
        } else {
            
            scoreLabel.text = "-"
        }
        
        let extLogo = UIImageView();
        extLogo.image = UIImage(named: myVar["resultats"]![indexPath.row]["ext_logo_name"]!)
        extLogo.frame = CGRect(x: innerView.frame.maxX - 40, y: dateLabel.frame.height, width: 40, height: 40)
        extLogo.contentMode = .scaleAspectFit;
        //extLogo.backgroundColor = .green;
        extLogo.autoresizingMask = [.flexibleLeftMargin]
        
        let extLabel = UILabel(frame: CGRect(x: 40 + 90 + 25, y: dateLabel.frame.height, width: 120, height: 40))
        extLabel.textAlignment = .right;
        //extLabel.backgroundColor = .orange;
        extLabel.text = myVar["resultats"]![indexPath.row]["ext_name"]!
        extLabel.autoresizingMask = [.flexibleLeftMargin]
        
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
