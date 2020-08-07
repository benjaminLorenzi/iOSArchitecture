//
//  TestHomeViewModel.swift
//  IOSArchitectureTests
//
//  Created by Benjamin LORENZI on 06/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//
import XCTest
@testable import IOSArchitecture

class MockPDriverWorker: BaseNetWorker {
    func setProfile(_ profile: Profile) {
        storeManager.cache.profile = profile
        storeManager.saveCache()
        dispatcher.post(event: .endProfileFetched)
    }
    
    func setTrips(_ trips: [Trip]) {
        storeManager.cache.tripList = trips
        storeManager.saveCache()
        dispatcher.post(event: .endProfileFetched)
    }
}

class TestHomeViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testMockDriverWorker() {
        DependenciesManager.main.storeManager.resetDatas()
        let dispatcher: Dispatcher = Dispatcher()
        let loginStatus: LoginStatus = LoginStatus(dispatcher: dispatcher)
        let profileStatus: ProfileStatus = ProfileStatus(dispatcher: dispatcher)
        let tripStatus: TripStatus = TripStatus(dispatcher: dispatcher)
        let dataManager:  DataManager = DataManager()
        let driverWorker = MockPDriverWorker()
        
        let homeViewModel = HomeViewModel(loginStatus: loginStatus, profileStatus: profileStatus, tripStatus: tripStatus, dataManager: dataManager)
        
        XCTAssert(homeViewModel.homeStatus == .loggedOut)
        dispatcher.post(event: .endLogin)
        XCTAssert(homeViewModel.homeStatus == .needRecovey)
        
        driverWorker.setProfile(Profile(username: "Paul"))
        dispatcher.post(event: .endProfileFetched)
        dispatcher.post(event: .endRefreshTrips)
        XCTAssert(homeViewModel.homeStatus == .needRecovey)
        
        driverWorker.setTrips([])
        dispatcher.post(event: .endProfileFetched)
        dispatcher.post(event: .endRefreshTrips)
        XCTAssert(homeViewModel.homeStatus == .loggedIn)
        
        dispatcher.post(event: .logOut)
        XCTAssert(homeViewModel.homeStatus == .loggedOut)
    }

    func testExample() {
        DependenciesManager.main.storeManager.resetDatas()
        let storeManager: StoreManager<ModelsStored> = DependenciesManager.main.storeManager
        let dispatcher: Dispatcher = Dispatcher()
        let loginStatus: LoginStatus = LoginStatus(dispatcher: dispatcher)
        let profileStatus: ProfileStatus = ProfileStatus(dispatcher: dispatcher)
        let tripStatus: TripStatus = TripStatus(dispatcher: dispatcher)
        let dataManager:  DataManager = DataManager()
        let homeViewModel = HomeViewModel(loginStatus: loginStatus, profileStatus: profileStatus, tripStatus: tripStatus, dataManager: dataManager)
        
        XCTAssert(homeViewModel.homeStatus == .loggedOut)
        dispatcher.post(event: .endLogin)
        XCTAssert(homeViewModel.homeStatus == .needRecovey)
        
        storeManager.cache.tripList = []
        storeManager.cache.profile = Profile(username: "Paul")
        storeManager.saveCache()
        dispatcher.post(event: .endProfileFetched)
        dispatcher.post(event: .endRefreshTrips)
        XCTAssert(homeViewModel.homeStatus == .loggedIn)
        
        dispatcher.post(event: .logOut)
        XCTAssert(homeViewModel.homeStatus == .loggedOut)
    }
}
