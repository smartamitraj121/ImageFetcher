//
//  ImageFetcherAppTests.swift
//  ImageFetcherAppTests
//
//  Created by Amit Kumar on 09/06/20.
//  Copyright © 2020 Amit Kumar. All rights reserved.
//

import XCTest
@testable import ImageFetcherApp

class ImageFetcherAppTests: XCTestCase {
    var apiManager:MockAPIManager!
    var mockViewController: ViewController!
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        mockViewController = ViewController()
        apiManager = MockAPIManager.sharedImgSpy
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        apiManager = nil
        mockViewController = nil
    }
    func testImageFetcherViewModel() {
        let row = Rows(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment.", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        let imageFetcherTestModel = ImageFetcherModel(title: "About Canada", rows: [row])
        let imageViewModel = ImageFetcherViewModel(model: imageFetcherTestModel)
        XCTAssertNotNil(imageViewModel)
        XCTAssertEqual(imageViewModel.title, "About Canada")
        XCTAssertEqual(imageViewModel.imageFetcherData[0].title, "Beavers")
        XCTAssertEqual(imageViewModel.imageFetcherData[0].imageHref, "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        XCTAssertEqual(imageViewModel.imageFetcherData[0].description, "Beavers are second only to humans in their ability to manipulate and change their environment.")
    }
    
    func testService(){
        let expectation = self.expectation(description: "should return response")
        var response: ImageFetcherModel?
        
        apiManager.getData(urlString: "") { (result) in
             switch result {
                       case .success(let imgData):
                        response = imgData
                        expectation.fulfill()
             case .failure( _):
                        response = nil
                        expectation.fulfill()
                       }
        }
        self.waitForExpectations(timeout: 0.5) { _ in
            XCTAssertNotNil(response)
            XCTAssertEqual(response?.title, "About Canada")
               }
    }
}

class MockAPIManager: APIManager {
    static let sharedImgSpy = MockAPIManager()
    override init() {}
    override func getData(urlString: String, completion: @escaping (Result<ImageFetcherModel, Error>) -> ()) {
        let row = Rows(title: "Beavers", description: "Beavers are second only to humans in their ability to manipulate and change their environment.", imageHref: "http://upload.wikimedia.org/wikipedia/commons/thumb/6/6b/American_Beaver.jpg/220px-American_Beaver.jpg")
        let imageFetcherTestModel = ImageFetcherModel(title: "About Canada", rows: [row])
        completion(.success(imageFetcherTestModel))
    }
}
