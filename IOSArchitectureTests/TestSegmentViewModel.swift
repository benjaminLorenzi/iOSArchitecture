//
//  TestSegmentViewModel.swift
//  IOSArchitectureTests
//
//  Created by Benjamin LORENZI on 03/03/2020.
//  Copyright © 2020 Benjamin LORENZI. All rights reserved.
//

import XCTest
@testable import IOSArchitecture

private class MockSegmentUpdate: SegmentViewModelDelegate {
    var segment: SegmentViewModel?
    
    init(segment: SegmentViewModel) {
        self.segment = segment
        updateUI()
    }
    
    var showRefreshSpinner: Bool = false
    var name: String = ""
    var hasBeenRemoved: Bool = false
    
    func updateUI() {
        guard let segment = self.segment else {
            return
        }
        showRefreshSpinner = segment.isRefreshing
        name = segment.name
        hasBeenRemoved = segment.isRemoved
    }
}


class TestSegmentViewModel: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    
    func testSegmentViewModelUIDelegate() {
        let storeManager = DependenciesManager.main.storeManager
        let mockManager = DataManager(storeManager: storeManager)
        let mockDispatcher = Dispatcher()
        let mockTripStatus = TripStatus(dispatcher: mockDispatcher)
        
        let segment1 = Segment(id: "seg1", name: "segment1")
        var trips = [
            Trip(id: "trip1", name: "seg1 -> seg4", segments: [
                segment1,
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
        
        let segmentViewModel = SegmentViewModel(segment: segment1, tripStatus: mockTripStatus, dataManager: mockManager)
        let mockSegmentUpdate = MockSegmentUpdate(segment: segmentViewModel)
        segmentViewModel.segmentViewModelDelegate = mockSegmentUpdate
        mockSegmentUpdate.segment = segmentViewModel
        
        XCTAssertFalse(mockSegmentUpdate.hasBeenRemoved)
        XCTAssertFalse(mockSegmentUpdate.showRefreshSpinner)
        XCTAssertEqual(mockSegmentUpdate.name, "segment1")
        
        trips = [
            Trip(id: "trip1", name: "seg1 -> seg4", segments: [
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
        mockDispatcher.post(event: .beginRefreshTrips)
        XCTAssertTrue(mockSegmentUpdate.showRefreshSpinner)
        
        
        storeManager.cache.tripList = trips
        storeManager.saveCache()
        mockDispatcher.post(event: .endRefreshTrips)
        
        XCTAssertTrue(mockSegmentUpdate.hasBeenRemoved)
        XCTAssertFalse(mockSegmentUpdate.showRefreshSpinner)
        XCTAssertEqual(mockSegmentUpdate.name, "segment1")
        
        mockDispatcher.post(event: .beginRefreshTrips)
        
        XCTAssertTrue(mockSegmentUpdate.hasBeenRemoved)
        XCTAssertTrue(mockSegmentUpdate.showRefreshSpinner)
        XCTAssertEqual(mockSegmentUpdate.name, "segment1")
        
        mockDispatcher.post(event: .endRefreshTrips)
        
        XCTAssertTrue(mockSegmentUpdate.hasBeenRemoved)
        XCTAssertFalse(mockSegmentUpdate.showRefreshSpinner)
        XCTAssertEqual(mockSegmentUpdate.name, "segment1")
    }
    

    func testSegmentViewModel() {
        let storeManager = DependenciesManager.main.storeManager
        let mockManager = DataManager(storeManager: storeManager)
        let mockDispatcher = Dispatcher()
        let segment = Segment(id: "seg1", name: "segment1")
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
        
        let segmentViewModel = SegmentViewModel(segment: segment, tripStatus: TripStatus(dispatcher: mockDispatcher), dataManager: mockManager)
        
        XCTAssertFalse(segmentViewModel.isRemoved)
        XCTAssertFalse(segmentViewModel.isRefreshing)
        XCTAssertEqual(segmentViewModel.name, "segment1")
        
        trips = [
            Trip(id: "trip1", name: "seg1 -> seg4", segments: [
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
        
        XCTAssertTrue(segmentViewModel.isRemoved)
        XCTAssertFalse(segmentViewModel.isRefreshing)
        XCTAssertEqual(segmentViewModel.name, "segment1")
        
        mockDispatcher.post(event: .beginRefreshTrips)
        
        XCTAssertTrue(segmentViewModel.isRemoved)
        XCTAssertTrue(segmentViewModel.isRefreshing)
        XCTAssertEqual(segmentViewModel.name, "segment1")
        
        mockDispatcher.post(event: .endRefreshTrips)
        
        XCTAssertTrue(segmentViewModel.isRemoved)
        XCTAssertFalse(segmentViewModel.isRefreshing)
        XCTAssertEqual(segmentViewModel.name, "segment1")
    }
}
