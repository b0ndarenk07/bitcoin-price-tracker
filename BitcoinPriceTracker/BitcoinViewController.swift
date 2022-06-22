//
//  BitcoinViewController.swift
//  BitcoinPriceTracker
//
//  Created by Vladislav Bondarenko on 6/22/22.
//

import UIKit

class BitcoinViewController: UIViewController {
    
    @IBOutlet weak var refreshTapped: UIBarButtonItem!
    @IBOutlet weak var eurLabel: UILabel!
    @IBOutlet weak var jpyLabel: UILabel!
    @IBOutlet weak var usdLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getPrice()
    }
    
    func getPrice() {
        if let url = URL(string:
                            "https://min-api.cryptocompare.com/data/price?fsym=BTC&tsyms=USD,JPY,EUR") {
            URLSession.shared.dataTask(with: url) { (data:Data?, response:URLResponse?, error:Error?) in
                if error==nil {
                    
                    if data != nil {
                        //                       print(String(data: data!, encoding: .utf8))
                        if let json = try? JSONSerialization.jsonObject(with: data!, options:[]) as? [String:Double]{
                            //                           print(json)
                            DispatchQueue.main.async {
                                
                                if let usdPrice = json["USD"] {
                                    
                                    self.usdLabel.text = self.getStringFor(price: usdPrice, currencyCode: "USD")
                                }
                                //Print EUR
                                if let eurPrice = json["EUR"] {
                                    //                                    print(eurPrice)
                                    //                                self.eurLabel.text = "$\(eurPrice)"
                                    self.eurLabel.text = self.getStringFor(price: eurPrice, currencyCode: "EUR")
                                }
                                //Print JPY
                                if let jpyPrice = json["JPY"] {
                                    //                                    print(jpyPrice)
                                    //                                self.jpyLabel.text = "$\(jpyPrice)"
                                    self.jpyLabel.text = self.getStringFor(price: jpyPrice, currencyCode: "JPY")
                                }
                            }
                            
                            
                        }
                        
                    }
                } else {
                    print("We have an error, Captain!")
                }
            }.resume()
        }
    }
    
    
    func getStringFor(price: Double, currencyCode: String) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = currencyCode
        if let priceString = formatter.string(from: NSNumber(value: price)){
            return priceString
        }
        return "Error"
    }
    // Refresh Button
    @IBAction func refreshTapped(_ sender: Any) {
        getPrice()
    }
}










