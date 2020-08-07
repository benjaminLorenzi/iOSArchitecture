//
//  TripAccountViewModel.swift
//  IOSArchitectureTests
//
//  Created by Benjamin LORENZI on 04/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

/*
import XCTest
@testable import IOSArchitecture

class MockDriver: Driver {
    var _profile: Profile = Profile(username: "Benjoo")
    
    override func getProfile(completion: @escaping HandlerCompletion<Profile>) {
        completion(_profile, nil)
    }
}

class MockProfileWorker: BaseNetWorker {
    func setProfile(_ profile: Profile) {
        storeManager.cache.profile = profile
        storeManager.saveCache()
        dispatcher.post(event: .endProfileFetched)
    }
}

class TripAccountViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testAccountWithMockDriver() {
        let dispatcher = Dispatcher()
        let dataManager = DataManager()
        let appStates = AppStates(dispatcher: dispatcher)
        let dependencies = GBTAccountDependencies(dataManager: dataManager, appStates: appStates)
    
        let driver = MockDriver()
        let profileWorker = ProfileWorker(dispatcher: dispatcher, driver: driver, dataManager: dataManager)
        let accountViewModel = GBTAccountViewModel(deps: dependencies)
        
        driver._profile = Profile(username: "Benji")
        profileWorker.refreshProfile(completion: {_,_ in })
        
        XCTAssertFalse(accountViewModel.biometryEnabled)
        XCTAssert(accountViewModel.username == "Benji")
        XCTAssert(accountViewModel.supportedBiometry == BiometryType.none)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.faceId.rawValue])
        XCTAssert(accountViewModel.supportedBiometry == BiometryType.faceId)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.touchId.rawValue])
        XCTAssert(accountViewModel.supportedBiometry == BiometryType.touchId)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.none.rawValue])
        XCTAssert(accountViewModel.supportedBiometry == BiometryType.none)
        
        driver._profile = Profile(username: "Paul")
        profileWorker.refreshProfile(completion: {_,_ in })
        XCTAssert(accountViewModel.username == "Paul")
        
        dispatcher.post(event: .biometryChanged, userInfo: ["enabled": true])
        XCTAssertTrue(accountViewModel.biometryEnabled)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["enabled": false])
        XCTAssertFalse(accountViewModel.biometryEnabled)
        
        XCTAssertFalse(accountViewModel.biometryEnabled)
    }
    
    func testAccountWithDispatcher() {
        let dispatcher = Dispatcher()
        let dataManager = DataManager()
        let profileWorker = MockProfileWorker(dispatcher: dispatcher, dataManager: dataManager)
        let appStates = AppStates(dispatcher: dispatcher)
        let store = UserDefaults.init(suiteName: UUID().uuidString )!
        let biometryState = BiometryState(store: store, dispatcher: dispatcher)
        appStates.biometryState = biometryState
        let dependencies = GBTAccountDependencies(dataManager: dataManager, appStates: appStates)
        let accountViewModel = GBTAccountViewModel(deps: dependencies)
        
        profileWorker.setProfile(Profile(username: "Benji"))
        
        XCTAssertFalse(accountViewModel.biometryEnabled)
        XCTAssert(accountViewModel.username == "Benji")
        XCTAssert(accountViewModel.supportedBiometry == BiometryType.none)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.faceId.rawValue])
        XCTAssert(accountViewModel.supportedBiometry == BiometryType.faceId)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.touchId.rawValue])
        XCTAssert(accountViewModel.supportedBiometry == BiometryType.touchId)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["supportedBiometry": BiometryType.none.rawValue])
        XCTAssertEqual(accountViewModel.supportedBiometry, BiometryType.none)
        
        profileWorker.setProfile(Profile(username: "Paul"))
        XCTAssertEqual(accountViewModel.username,"Paul")
        
        dispatcher.post(event: .biometryChanged, userInfo: ["enabled": true])
        XCTAssertTrue(accountViewModel.biometryEnabled)
        
        dispatcher.post(event: .biometryChanged, userInfo: ["enabled": false])
        XCTAssertFalse(accountViewModel.biometryEnabled)
    }

}
*/
