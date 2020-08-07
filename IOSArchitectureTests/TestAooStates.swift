//
//  TestAooStates.swift
//  IOSArchitectureTests
//
//  Created by Benjamin LORENZI on 05/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import XCTest
@testable import IOSArchitecture

class TestAooStates: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testLoginState() {
        let dispatcher = Dispatcher()
        let appState = AppStates(dispatcher: dispatcher)
        
        XCTAssert(appState.loginStatus.loginState.value == .loggedOut)
        dispatcher.post(event: .beginLogin)
        XCTAssert(appState.loginStatus.loginRefreshing.value == true)
        XCTAssert(appState.loginStatus.loginState.value == .loggedOut)
        dispatcher.post(event: .logOut)
        XCTAssert(appState.loginStatus.loginRefreshing.value == false)
        XCTAssert(appState.loginStatus.loginState.value == .loggedOut)
        
        dispatcher.post(event: .beginLogin)
        XCTAssert(appState.loginStatus.loginRefreshing.value == true)
        XCTAssert(appState.loginStatus.loginState.value == .loggedOut)
        dispatcher.post(event: .endLogin)
        XCTAssert(appState.loginStatus.loginRefreshing.value == false)
        XCTAssert(appState.loginStatus.loginState.value == .loggedIn)
    }
    
    func testTripState() {
        let dispatcher = Dispatcher()
        let appState = AppStates(dispatcher: dispatcher)
        
        XCTAssert(appState.tripStatus.value.isRefreshing == false)
        dispatcher.post(event: .endRefreshTrips)
        XCTAssert(appState.tripStatus.value.isRefreshing == false)
        dispatcher.post(event: .beginRefreshTrips)
        XCTAssert(appState.tripStatus.value.isRefreshing == true)
        dispatcher.post(event: .endRefreshTrips)
        XCTAssert(appState.tripStatus.value.isRefreshing == false)
    }
    
    func testProfileStatus() {
        let dispatcher = Dispatcher()
        let appState = AppStates(dispatcher: dispatcher)
        
        XCTAssert(appState.profileStatus.value == false)
        dispatcher.post(event: .endProfileFetched)
        XCTAssert(appState.profileStatus.value == false)
        dispatcher.post(event: .beginProfileFetched)
        XCTAssert(appState.profileStatus.value == true)
        dispatcher.post(event: .endProfileFetched)
        XCTAssert(appState.profileStatus.value == false)
    }
    
    func testBiometryState() {
        let dispatcher = Dispatcher()
        let biometryState = BiometryState(store: UserDefaults.init(suiteName: UUID().uuidString )!, dispatcher: dispatcher)
        
        XCTAssert(biometryState.value.enabled == false)
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.faceId.rawValue])
        XCTAssert(biometryState.value.supportedBiometry == BiometryType.faceId)
        XCTAssert(biometryState.value.enabled == false)
        
        XCTAssert(biometryState.value.enabled == false)
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.touchId.rawValue])
        XCTAssert(biometryState.value.supportedBiometry == BiometryType.touchId)
        XCTAssert(biometryState.value.enabled == false)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.none.rawValue])
        XCTAssert(biometryState.value.supportedBiometry == BiometryType.none)
        XCTAssert(biometryState.value.enabled == false)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["enabled": false])
        XCTAssert(biometryState.value.enabled == false)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["enabled": true])
        XCTAssert(biometryState.value.enabled == true)
        XCTAssert(biometryState.value.supportedBiometry == BiometryType.none)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.touchId.rawValue, "enabled": true])
        XCTAssert(biometryState.value.supportedBiometry == BiometryType.touchId)
        XCTAssert(biometryState.value.enabled == true)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.faceId.rawValue])
        XCTAssert(biometryState.value.supportedBiometry == BiometryType.faceId)
        XCTAssert(biometryState.value.enabled == true)
        
    }
       

}
