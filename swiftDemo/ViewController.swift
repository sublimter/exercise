//  ViewController.swift
//  Created on 2018/5/28
//  Description <#文件描述#>

//  Copyright © 2018年 Huami inc. All rights reserved.
//  @author luoliangliang(luoliangliang@huami.com)

import UIKit
import SnapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let label = UILabel()
    
    let locationManager = CLLocationManager()
    let geocoder = CLGeocoder()
    let locationlabel = UILabel()
    let locationStrLabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 背景虚化
        let blurEffect: UIBlurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView: UIVisualEffectView = UIVisualEffectView(effect: blurEffect)
        blurView.frame = view.bounds
        view.addSubview(blurView)
        
        locationManager.delegate = self
        
        locationlabel.frame = CGRect(x: 0, y: 50, width: self.view.bounds.width, height: 100)
        locationlabel.textAlignment = .center
        locationlabel.textColor = UIColor.white
        view.addSubview(locationlabel)
        
        locationStrLabel.frame = CGRect(x: 0, y: 100, width: self.view.bounds.width, height: 50)
        locationStrLabel.textAlignment = .center
        locationStrLabel.textColor = UIColor.white
        view.addSubview(locationStrLabel)
        
        let findMyLocationBtn = UIButton(type: .custom)
        findMyLocationBtn.frame = CGRect(x: 50, y: self.view.bounds.height - 80, width: self.view.bounds.width - 100, height: 50)
        findMyLocationBtn.setTitle("Find My Position", for: UIControlState.normal)
        findMyLocationBtn.setTitleColor(UIColor.white, for: UIControlState.normal)
        findMyLocationBtn.addTarget(self, action: #selector(findMyLocation), for: UIControlEvents.touchUpInside)
        view.addSubview(findMyLocationBtn)
        
        
        // 输出所有支持的 family font name
        printAllSupportedFontName()
        
        /*
        // Do any additional setup after loading the view, typically from a nib.
        label.text = "这是一个测试文字"
        label.textAlignment = NSTextAlignment.center
        view.addSubview(label)
        label.snp.makeConstraints { (make) in
            make.top.equalTo(100)
            make.centerX.equalTo(view)
        }
        label.font = UIFont.systemFont(ofSize: 20)
        
        let changeBtn = UIButton(type: .custom)
        changeBtn.setTitle("改变文字的字体", for: .normal)
        changeBtn.addTarget(self, action: #selector(changeFont), for: .touchUpInside)
        changeBtn.setTitleColor(UIColor.blue, for: UIControlState.normal)
        view.addSubview(changeBtn)
        changeBtn.layer.borderColor = UIColor.blue.cgColor
        changeBtn.layer.borderWidth = 1.0
        changeBtn.layer.cornerRadius = 5
        changeBtn.snp.makeConstraints { (make) in
            make.top.equalTo(500)
            make.centerX.equalTo(view)
            make.width.equalTo(200)
        }
        */
    
    }
    
    @objc func findMyLocation() {
        locationManager.requestAlwaysAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    /// 定位代理 func
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let locations: NSArray = locations as NSArray
        let currentLocation = locations.lastObject as! CLLocation
        let locationStr = "lat:\(currentLocation.coordinate.latitude),log:\(currentLocation.coordinate.longitude)"
        locationStrLabel.text = locationStr
        reverseGeocode(location: currentLocation)
        // 停止定位
        locationManager.stopUpdatingLocation()
    }
    
    /// 将经纬度转换为城市名
    func reverseGeocode(location: CLLocation) {
        geocoder.reverseGeocodeLocation(location) { (placeMark, error) in
            if error == nil {
                let tempArray = placeMark! as NSArray
                let mark = tempArray.firstObject as! CLPlacemark
                
                let addressDictionary = mark.addressDictionary! as NSDictionary
                let country = addressDictionary.value(forKey: "Country") as! String
                let city = addressDictionary.object(forKey: "City") as! String
                let street = addressDictionary.object(forKey: "Street") as! String
                
                let finalAddress = "\(street),\(city),\(country)"
                self.locationStrLabel.text = finalAddress
            }
        }
    }
    
    @objc func changeFont() {
        label.font = UIFont(name: "Savoye LET", size: 30)
    }
    
    func printAllSupportedFontName() {
        let familyNames = UIFont.familyNames
        for familyName in familyNames {
            print("++++ \(familyName)")
            let fontNames = UIFont.fontNames(forFamilyName: familyName)
            for fontName in fontNames {
                print("----- \(fontName)")
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

