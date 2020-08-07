//
//  TripTestViewModel.swift
//  IOSArchitectureTests
//
//  Created by Benjamin LORENZI on 03/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import XCTest
@testable import IOSArchitecture

/*
 This MockTripUpdate simulate a UIViewController that should call updateUI
 */
private class MockTripUpdate: TripViewModelDelegate {
    var trip: TripViewModel?
    
    init(trip: TripViewModel) {
        self.trip = trip
        updateUI()
    }
    
    var showRefreshSpinner: Bool = false
    var name: String = ""
    var hasBeenRemoved: Bool = false
    
    func updateUI() {
        showRefreshSpinner = trip?.isRefreshing ?? false
        name = trip?.name ?? ""
        hasBeenRemoved = trip?.isRemoved ?? false
    }
}

class TripTestViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    /*
     test tripViewModel update from call directly on a dummy dispatcher
     dataManager and tripStatus are dependencies to inject in the viewModel
     there are also dummys interacting with the private dummy dispatcher
     
     the dispatcher post global event and we test that tripViewModel interact correctly with it
     
     */
    func testViewModelWithDispatcherPayload() {
        let mockDispatcher = Dispatcher()
        let storeManager = StoreManager<ModelsStored>(storage: DiskStorage(), storageKey: "test", version: "1.0", defaultValue: ModelsStored())
        let mockDataManager = DataManager(storeManager: storeManager)
        let tripStatus = TripStatus(dispatcher: mockDispatcher)
        
        var trips = [
            Trip(id: "trip1", name: "seg1 -> seg4", segments: [
                Segment(id: "seg1", name: "segment1"),
                Segment(id: "seg2", name: "segment2"),
                Segment(id: "seg3", name: "segment3"),
                Segment(id: "seg4", name: "segment4"),
            ]),
            Trip(id: "trip2", name: "seg4 -> seg8", segments: [
                Segment(id: "seg4", name: "segment4"),
                Segment(id: "seg5", name: "segment5"),
                Segment(id: "seg6", name: "segment6"),
                Segment(id: "seg7", name: "segment7"),
            ])
        ]
        
        storeManager.cache.tripList = trips
        storeManager.saveCache()
        mockDispatcher.post(event: .endRefreshTrips)
        
        let mockTripViewModel = TripViewModel(trip: trips.first!, tripStatus: tripStatus, dataManager: mockDataManager)
        
        XCTAssertFalse(mockTripViewModel.isRemoved)
        XCTAssertFalse(mockTripViewModel.isRefreshing)
        XCTAssertEqual(mockTripViewModel.name, "seg1 -> seg4")
        
        trips = [
            Trip(id: "trip2", name: "seg4 -> seg8", segments: [
                Segment(id: "seg4", name: "segment4"),
                Segment(id: "seg5", name: "segment5"),
                Segment(id: "seg6", name: "segment6"),
                Segment(id: "seg7", name: "segment7"),
            ])
        ]
        
        storeManager.cache.tripList = trips
        storeManager.saveCache()
        mockDispatcher.post(event: .endRefreshTrips)
        
        XCTAssertTrue(mockTripViewModel.isRemoved)
        XCTAssertFalse(mockTripViewModel.isRefreshing)
        XCTAssertEqual(mockTripViewModel.name, "seg1 -> seg4")
        
        mockDispatcher.post(event: .beginRefreshTrips)
        
        XCTAssertTrue(mockTripViewModel.isRemoved)
        XCTAssertTrue(mockTripViewModel.isRefreshing)
        XCTAssertEqual(mockTripViewModel.name, "seg1 -> seg4")
        
        mockDispatcher.post(event: .endRefreshTrips)
        
        XCTAssertTrue(mockTripViewModel.isRemoved)
        XCTAssertFalse(mockTripViewModel.isRefreshing)
        XCTAssertEqual(mockTripViewModel.name, "seg1 -> seg4")
    }

    /*
    test tripViewModelUIDelegate test
    mockTripUpdate is a fake UIViewController
    we tests that its values are updated
    
    mockManager allow us to change the tripList which is normally not allowed.
    (DataManager allows only read access on its variables that are only updated after receiving a dispatcher event (endFetchTrips for example).
    tripList is a DynamicValue : by changing it, it will trigger a tripViewModel update.
    */
    func testTestViewModelUIDelegate() {
        let storeManager = DependenciesManager.main.storeManager
        let mockDataManager = DataManager(storeManager: storeManager)
        let mockDispatcher = Dispatcher()
       
        var trips = [
            Trip(id: "trip1", name: "seg1 -> seg4", segments: [
                Segment(id: "seg1", name: "segment1"),
                Segment(id: "seg2", name: "segment2"),
                Segment(id: "seg3", name: "segment3"),
                Segment(id: "seg4", name: "segment4"),
            ]),
            Trip(id: "trip2", name: "seg4 -> seg8", segments: [
                Segment(id: "seg4", name: "segment4"),
                Segment(id: "seg5", name: "segment5"),
                Segment(id: "seg6", name: "segment6"),
                Segment(id: "seg7", name: "segment7"),
            ])
        ]
        
        storeManager.cache.tripList = trips
        storeManager.saveCache()
        mockDispatcher.post(event: .endRefreshTrips)
        
        let mockTripViewModel = TripViewModel(trip: trips.first!, tripStatus: TripStatus(dispatcher: mockDispatcher), dataManager: mockDataManager)
        let mockTripUpdate = MockTripUpdate(trip: mockTripViewModel)
        mockTripViewModel.tripViewModelDelegate = mockTripUpdate
        mockTripUpdate.trip = mockTripViewModel
        
        XCTAssertFalse(mockTripUpdate.hasBeenRemoved)
        XCTAssertFalse(mockTripUpdate.showRefreshSpinner)
        XCTAssertEqual(mockTripUpdate.name, "seg1 -> seg4")
        
        trips = [
            Trip(id: "trip2", name: "seg4 -> seg8", segments: [
                Segment(id: "seg4", name: "segment4"),
                Segment(id: "seg5", name: "segment5"),
                Segment(id: "seg6", name: "segment6"),
                Segment(id: "seg7", name: "segment7"),
            ])
        ]
        
        storeManager.cache.tripList = trips
        storeManager.saveCache()
        mockDispatcher.post(event: .endRefreshTrips)
        
        XCTAssertTrue(mockTripUpdate.hasBeenRemoved)
        XCTAssertFalse(mockTripUpdate.showRefreshSpinner)
        XCTAssertEqual(mockTripUpdate.name, "seg1 -> seg4")
        
        mockDispatcher.post(event: .beginRefreshTrips)
        
        XCTAssertTrue(mockTripUpdate.hasBeenRemoved)
        XCTAssertTrue(mockTripUpdate.showRefreshSpinner)
        XCTAssertEqual(mockTripUpdate.name, "seg1 -> seg4")
        
        mockDispatcher.post(event: .endRefreshTrips)
        
        XCTAssertTrue(mockTripUpdate.hasBeenRemoved)
        XCTAssertFalse(mockTripUpdate.showRefreshSpinner)
        XCTAssertEqual(mockTripUpdate.name, "seg1 -> seg4")
    }
    

}
