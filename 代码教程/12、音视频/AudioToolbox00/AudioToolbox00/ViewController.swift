//
//  ViewController.swift
//  AudioToolbox00
//
//  Created by 高广校 on 2023/12/1.
//

import UIKit
import AudioToolbox

struct AQPlayerState {
    //如果`mDataFormat`为可选，传递引用关系并不大
    var mDataFormat:AudioStreamBasicDescription = AudioStreamBasicDescription()
    var mQueue:AudioQueueRef?
    var mBuffers:AudioQueueBufferRef?
    var mAudioFile: AudioFileID?
    var bufferByteSize:UInt32 = 0
    var mCurrentPacket:Int64 = 0
    var mNumPacketsToRead:UInt32 = 0
    var mPacketDescs : UnsafeMutablePointer<AudioStreamPacketDescription>?
    var mIsRunning : Bool = false
    init(){
        
    }
}


//回调函数(Callback)的实现
//void HandleOutputBuffer(aqData: UnsafeMutableRawPointer,
//                    inAQ: AudioQueueRef,
//                    inBuffer: AudioQueueBufferRef){
//    print(inBuffer)
////    BXAudioPlayer* player=(__bridge BXAudioPlayer*)inUserData;
////    [player audioQueueOutputWithQueue:inAQ queueBuffer:buffer];
//}

func HandleOutputBuffer(aqData: UnsafeMutableRawPointer?,
                        inAQ: AudioQueueRef,
                        bufferToFill: UnsafeMutablePointer<AudioQueueBuffer>) {

//    guard let user = userData else {
//        return
//    }
    
}


class ViewController: UIViewController {
    
    
    
    var aqData : AQPlayerState = AQPlayerState()
    
    lazy var url: URL = {
        let path = Bundle.main.path(forResource: "VoiceOriginFile", ofType: "wav")
        let uurl = URL(fileURLWithPath: path ?? "")
        
        return uurl
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        //1、AudioFile打开
        let status = AudioFileOpenURL(url as CFURL, .readPermission, 0, &aqData.mAudioFile)
        print("status:\(status)")

        guard let audioFile = aqData.mAudioFile else { return }
        //2、取得音频数据格式
        var dataFormatSize: UInt32 = UInt32(MemoryLayout<AudioStreamBasicDescription>.size)
        AudioFileGetProperty(audioFile, kAudioFilePropertyDataFormat, &dataFormatSize, &aqData.mDataFormat)
        print("mDataFormat:\(aqData.mDataFormat.mSampleRate)")
        
        //3、创建播放用的音频队列
        AudioQueueNewOutput(&aqData.mDataFormat,
                            HandleOutputBuffer,
                            &aqData,
                            nil,
                            nil,
                            0,
                            &aqData.mQueue)
        
        //4设置音频播放队列大小
        var propertySize: UInt32 = UInt32(MemoryLayout<UInt32>.size)
        var maxPacketSize: UInt32 = 0
        AudioFileGetProperty(audioFile, kAudioFilePropertyPacketSizeUpperBound, &propertySize, &maxPacketSize)
        
        print("音频队列大小\(maxPacketSize)")
        
    }
    
    
}

