//
//  DetailViewControllerTests.swift
//  rocketTestV2
//
//  Created by Federico Frias on 8/27/15.
//  Copyright (c) 2015 Bminds. All rights reserved.
//

import UIKit
import XCTest
import swiftTest

class DetailViewControllerTests: XCTestCase {
    var VC: DetailViewController!
    
    override func setUp() {
        super.setUp()
        self.VC = UIStoryboard(name: "Main", bundle: NSBundle(forClass: self.classForCoder)).instantiateViewControllerWithIdentifier("detailViewController") as! DetailViewController
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testSetInitialData() {
        var testSong = Song(image: "image", name: "song", track: "the track", price: "5.00")
        var setOk:Bool = self.VC.setInitialData(testSong)
        XCTAssertFalse(setOk, "There was an error setting initial data on DetailViewController")
    }


}
