//
//  DetailViewController.swift
//  MVVMPOC
//
//  Created by CSS CORP on 17/01/19.
//  Copyright © 2019 CSS CORP. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    var data:[String] = []
    
    @IBOutlet weak var imageView: UIImageView!
    var messierViewModel:MessierViewModel?
    
    @IBOutlet weak var firstLabel: UILabel!
    
    @IBOutlet weak var detailLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
//        firstLabel.text = data[0]
//        detailLabel.text = data[0]+"subtitle"
        
            // the user chose to inspect.
        print(messierViewModel?.formalName as Any)
        print(messierViewModel?.commonName as Any)
        print(messierViewModel?.dateUpdated as Any)
        print(messierViewModel?.textDescription as Any)
        
        firstLabel.text = messierViewModel?.formalName
        detailLabel.attributedText = messierViewModel?.textDescription
        
        imageView.alpha = 0.0
        
        let imageCompletionClosuer = {(imageData: NSData) ->Void in
            
            DispatchQueue.main.async {
                
                UIView.animate(withDuration: 1.0, animations: {
                    
                    self.imageView.alpha = 1.0
                    self.imageView.image = UIImage(data: imageData as Data)
                    self.view.setNeedsDisplay()
                })
            }
        }
        
        messierViewModel?.download(completionHanlder: imageCompletionClosuer)
        
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
