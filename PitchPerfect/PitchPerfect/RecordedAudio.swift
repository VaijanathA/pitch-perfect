//
//  RecordedAudio.swift
//  PitchPerfect
//
//  Created by Vaijanath Angadihiremath on 4/5/15.
//  Copyright (c) 2015 com.voidangle. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    init(filePathUrl :NSURL, title:String){
        self.filePathUrl = filePathUrl
        self.title = title
    }

}