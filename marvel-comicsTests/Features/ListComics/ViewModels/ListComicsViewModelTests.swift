//
//  ListComicsViewModelTests.swift
//  marvel-comicsTests
//
//  Created by Bruno Duarte on 11/12/22.
//

import XCTest

class ListComicsViewModelTests: XCTestCase {
    
    var request: HttpRequest? = nil
    var configuration = ProdAppConfig.shared
    
    var expectation: XCTestExpectation?
    
    var lastErrorTitle = ""
    var lastErrorMessage = ""
    
    override func setUp() {
        request = UrlSessionRequest(configuration)
        lastErrorTitle = ""
        lastErrorMessage = ""
    }
    
    func testUpdateComicsResultWithSuccess() throws {
        let request = try XCTUnwrap(request)
        let service = ListComicsServiceWithSuccessMock(request)
        let viewModel = ListComicsViewModel(service: service, coordinatorDelegate: self)
        viewModel.delegate = self
        
        expectation = expectation(description: "ViewModel ComicsResult updates.")
        viewModel.updateComicsResult()
        
        waitForExpectations(timeout: 10)
        
        XCTAssertNotNil(viewModel.comicsResult)
    }
    
    func testUpdateComicsResultWithTransportError() throws {
        let request = try XCTUnwrap(request)
        let service = ListComicsServiceWithTransportErrorMock(request)
        let viewModel = ListComicsViewModel(service: service, coordinatorDelegate: self)
        viewModel.delegate = self
        
        expectation = expectation(description: "ViewModel return error.")
        viewModel.updateComicsResult()
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(lastErrorTitle, "Ops")
        XCTAssertEqual(lastErrorMessage, "Ocorreu um erro de conexão, por favor verifique a sua conexão ou tente novamente mais tarde.")
    }
    
    func testUpdateComicsResultWithServerSideError() throws {
        let request = try XCTUnwrap(request)
        let service = ListComicsServiceWithServerSideErrorMock(request)
        let viewModel = ListComicsViewModel(service: service, coordinatorDelegate: self)
        viewModel.delegate = self
        
        expectation = expectation(description: "ViewModel ComicsResult updates.")
        viewModel.updateComicsResult()
        
        waitForExpectations(timeout: 10)
        
        XCTAssertEqual(lastErrorTitle, "Ops")
        XCTAssertEqual(lastErrorMessage, "Ocorreu um erro no sistema, por favor tente novamente mais tarde.")
    }
}

// MARK: - ListComicsViewModelCoordinatorDelegate

extension ListComicsViewModelTests: ListComicsViewModelCoordinatorDelegate {
    func showComicDetail(_ comic: Comic) {
        
    }
}

// MARK: - ListComicsViewModelDelegate

extension ListComicsViewModelTests: ListComicsViewModelDelegate {
    func comicsResultUpdated() {
        expectation?.fulfill()
        expectation = nil
    }
    
    func showErrorAlert(title: String, message: String) {
        lastErrorTitle = title
        lastErrorMessage = message
        expectation?.fulfill()
        expectation = nil
    }
}

// MARK: - Mock

class ListComicsServiceWithSuccessMock: ListComicsServiceProtocol {
    required init(_ request: HttpRequest) { }
    
    func getComics(completion: @escaping (Result<ComicsResult, HttpError>) -> Void) {
        guard let path = Bundle.main.path(forResource: "ComicResult", ofType: "json") else {
            fatalError("Can't find ComicResult.json file.")
        }

        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            let result = try JSONDecoder().decode(ComicsResult.self, from: data)
            completion(.success(result))
        } catch {
            fatalError("Can't parse ComicResult.json file to ComicsResult object.")
        }
    }
}

class ListComicsServiceWithTransportErrorMock: ListComicsServiceProtocol {
    required init(_ request: HttpRequest) { }
    
    func getComics(completion: @escaping (Result<ComicsResult, HttpError>) -> Void) {
        completion(.failure(.transportError(nil)))
    }
}

class ListComicsServiceWithServerSideErrorMock: ListComicsServiceProtocol {
    required init(_ request: HttpRequest) { }
    
    func getComics(completion: @escaping (Result<ComicsResult, HttpError>) -> Void) {
        completion(.failure(.serverSideError(500)))
    }
}
