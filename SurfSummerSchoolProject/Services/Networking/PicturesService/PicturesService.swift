//
//  PicturesService.swift
//  SurfSummerSchoolProject
//
//  Created by Zhasur Sidamatov on 09/08/22.
//

import Foundation


struct PicturesService {
    
    let dataTask = BaseNetworkTask<EmptyModel, [PictureResponseModel]>(isNeedInjectToken: true, method: .get, path: "picture/")
    
    func loadPictures(_ onResponseWasReceived: @escaping (_ result: Result<[PictureResponseModel], Error>) -> Void) {
        dataTask.performRequest(onResponseWasReceived)
    }
    
    func pullToRefresh(_ onResponseWasReceived: @escaping (_ result: Result<[PictureResponseModel], RefreshError>) -> Void) {
        dataTask.performRefresh(onResponseWasReceived)
    }
}
