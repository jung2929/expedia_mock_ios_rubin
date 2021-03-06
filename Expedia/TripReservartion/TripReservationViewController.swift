//
//  ViewController.swift
//  Expedia
//
//  Created by YooBin Jo on 01/04/2019.
//  Copyright © 2019 YooBin Jo. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class TripReservationViewController: UIViewController {
    
    let reservateHotelButtonColor: UIColor = UIColor()
    let data = LoginInfoData()
    var jsonData: JSON?
    

    @IBOutlet weak var topLogoView: UIView!
    @IBOutlet weak var reservateHotelButton: UIButton!
    @IBOutlet weak var menuListTable: UITableView!
    @IBAction func reservationHottelButtonAction(_ sender: Any) {
    }
    
    func updateUI() {
        self.topLogoView.layer.addBorder([.bottom], color: UIColor.lightGray, width: 1.0)
        self.reservateHotelButton.layer.addBorder([.bottom], color: reservateHotelButtonColor.UIColorFromRGB(rgbValue: 0xFFCB06), width: 3.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        menuListTable.delegate = self
        menuListTable.dataSource = self
        
        self.updateUI()
        
        let beforeLoginNibName = UINib(nibName: "BeforeLoginTableViewCell", bundle: nil)
        menuListTable.register(beforeLoginNibName, forCellReuseIdentifier: "beforeLoginTVC")
        let todayPriceNibName = UINib(nibName: "TodayPriceTableViewCell", bundle: nil)
        menuListTable.register(todayPriceNibName, forCellReuseIdentifier: "todayPriceTVC")
        let eightPriceNibName = UINib(nibName: "EightPriceHotelTableViewCell", bundle: nil)
        menuListTable.register(eightPriceNibName, forCellReuseIdentifier: "eightPriceTVC")
        let daydayPriceNibName = UINib(nibName: "DayDayPriceTableViewCell", bundle: nil)
        menuListTable.register(daydayPriceNibName, forCellReuseIdentifier: "daydayPriceTVC")
        let limitedPriceNibName = UINib(nibName: "LimitedDatePriceTableViewCell", bundle: nil)
        menuListTable.register(limitedPriceNibName, forCellReuseIdentifier: "limitedDatePriceTVC")
        let memberPriceNibName = UINib(nibName: "MemberPriceTableViewCell", bundle: nil)
        menuListTable.register(memberPriceNibName, forCellReuseIdentifier: "memberPriceCell")
        
    }
    override func viewDidAppear(_ animated: Bool) {
        self.menuListTable.reloadData()
    }
    
    @objc func presentLoginOrRegisterVC() {
        performSegue(withIdentifier: "showLoginOrRegisterVC1", sender: nil)
    }
    @objc func presentEightPriceVC() {
        Alamofire.request(URL(string: "http://www.kaca5.com/expedia/discounted_80000")!, method: .get).validate().responseJSON { response in
            switch response.result {
            case .success(let data):
                self.jsonData = JSON(data)
            case .failure(let error):
                print(error)
            }
            let storyboard = self.storyboard!
            let eightPriceVC = storyboard.instantiateViewController(withIdentifier: "eightPriceVC") as! EightPriceHotelViewController
            eightPriceVC.hotelData = self.jsonData!["result"]
//            print(eightPriceVC.hotelData![0])
            self.present(eightPriceVC, animated: true, completion: nil)
        }
    }


}
extension TripReservationViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if self.data.loadLogin() == false {
            if indexPath.row == 0 {
                guard let beforeLoginCell = menuListTable.dequeueReusableCell(withIdentifier: "beforeLoginTVC", for: indexPath) as? BeforeLoginTableViewCell else { return UITableViewCell() }
                beforeLoginCell.updateUI()
                beforeLoginCell.loginOrRegisterButton.addTarget(self, action: #selector(presentLoginOrRegisterVC), for: .touchUpInside)
                return beforeLoginCell
            } else if indexPath.row == 1 {
                guard let todayPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "todayPriceTVC", for: indexPath) as? TodayPriceTableViewCell else { return UITableViewCell() }
                return todayPriceCell
            } else if indexPath.row == 2 {
                guard let eightPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "eightPriceTVC", for: indexPath) as? EightPriceHotelTableViewCell else { return UITableViewCell() }
                eightPriceCell.updateUI()
                eightPriceCell.imageButton.addTarget(self, action: #selector(presentEightPriceVC), for: .touchUpInside)
                return eightPriceCell
            } else if indexPath.row == 3 {
                guard let daydayPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "daydayPriceTVC", for: indexPath) as? DayDayPriceTableViewCell else { return UITableViewCell() }
                daydayPriceCell.updateUI()
                return daydayPriceCell
            } else {
                guard let limitedPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "limitedDatePriceTVC", for: indexPath) as? LimitedDatePriceTableViewCell else { return UITableViewCell() }
                limitedPriceCell.updateUI()
                return limitedPriceCell
            }
        } else if self.data.loadLogin() {
            if indexPath.row == 0 {
                guard let todayPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "todayPriceTVC", for: indexPath) as? TodayPriceTableViewCell else { return UITableViewCell() }
                return todayPriceCell
            } else if indexPath.row == 1 {
                guard let eightPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "eightPriceTVC", for: indexPath) as? EightPriceHotelTableViewCell else { return UITableViewCell() }
                eightPriceCell.updateUI()
                eightPriceCell.imageButton.addTarget(self, action: #selector(presentEightPriceVC), for: .touchUpInside)
                return eightPriceCell
            } else if indexPath.row == 2 {
                guard let daydayPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "daydayPriceTVC", for: indexPath) as? DayDayPriceTableViewCell else { return UITableViewCell() }
                daydayPriceCell.updateUI()
                return daydayPriceCell
            } else if indexPath.row == 3 {
                guard let memberPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "memberPriceCell", for: indexPath) as? MemberPriceTableViewCell else { return UITableViewCell() }
                memberPriceCell.updateUI()
                return memberPriceCell
            } else {
                guard let limitedPriceCell = menuListTable.dequeueReusableCell(withIdentifier: "limitedDatePriceTVC", for: indexPath) as? LimitedDatePriceTableViewCell else { return UITableViewCell() }
                limitedPriceCell.updateUI()
                return limitedPriceCell
            }
        }
        return UITableViewCell()
    }
    
    
}
