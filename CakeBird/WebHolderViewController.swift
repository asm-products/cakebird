//
//  WebHolderViewController.swift
//  CakeBird
//
//  Created by Rhett Rogers on 2/9/15.
//  Copyright (c) 2015 Lyokotech. All rights reserved.
//

import UIKit

class WebHolderViewController: SuperViewController {
  
  @IBOutlet weak var webView: UIWebView!
  
  var request: NSURLRequest?
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    if let req = request {
      webView.loadRequest(req)
    } else {
      fatalError("Needs request!")
    }
    // Do any additional setup after loading the view.
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
  /*
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
  // Get the new view controller using segue.destinationViewController.
  // Pass the selected object to the new view controller.
  }
  */
  
}
