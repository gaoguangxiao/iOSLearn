//
//  ViewController.swift
//  AudioToolbox00
//
//  Created by 高广校 on 2023/12/1.
//

import UIKit
import AudioToolbox

let maxBufferSize: UInt32 = 0x10000                                        // limit size to 64K
let minBufferSize: UInt32 = 0x4000
let maxBufferNum = 3

class Utility {
    //
    // convert a Core Audio error code to a printable string
    //
    static func codeToString(_ error: OSStatus) -> String {
        
        // byte swap the error
        let errorCode = CFSwapInt32HostToBig(UInt32(bitPattern: error))
        
        // separate the UInt32 into 4 bytes
        var bytes = [UInt8](repeating: 0, count: 4)
        bytes[0] = UInt8(errorCode & 0x000000ff)
        bytes[1] = UInt8( (errorCode & 0x0000ff00) >> 8)
        bytes[2] = UInt8( (errorCode & 0x00ff0000) >> 16)
        bytes[3] = UInt8( (errorCode & 0xff000000) >> 24)
        
        // do the four bytes all represent printable characters?
        if isprint(Int32(bytes[0])) != 0 && isprint(Int32(bytes[1])) != 0 &&
            isprint(Int32(bytes[2])) != 0 && isprint(Int32(bytes[3])) != 0 {
            
            // YES, return a String made from them
            return String(bytes: bytes, encoding: String.Encoding.ascii)!
            
        } else {
            
            // NO, treat the UInt32 as a number and create a String of the number
            return String(format: "%d", error)
        }
    }
    
    static func check(error: OSStatus , operation: String) {
        
        // return if no error
        if error == noErr { return }
        
        // print either four characters or the numeric value
        Swift.print("Error: \(operation), returned: \(codeToString(error))")
        
        // terminate the program
        exit(1)
    }
}

struct AQPlayerState {
    //如果`mDataFormat`为可选，传递引用关系并不大
    //    var mDataFormat:AudioStreamBasicDescription?
    //    var mDataFormat:AudioStreamBasicDescription = AudioStreamBasicDescription()
    //    var mQueue:AudioQueueRef?
    //    var mBuffers:AudioQueueBufferRef?
    var mAudioFile: AudioFileID?
    //    var mCurrentPacket:Int64 = 0
    var bufferByteSize: UInt32 = 0 //缓冲区大小
    var mNumPacketsToRead: UInt32 = 0
    
    var mPacketDescs : UnsafeMutablePointer<AudioStreamPacketDescription>?
    var mIsRunning : Bool = false
        init(){
    
        }
    
    var packetPosition: Int64 = 0                                           // current packet index in output file
    //    var numPacketsToRead: UInt32 = 0                                        // number of packets to read from file
//    var packetDescs: UnsafeMutablePointer<AudioStreamPacketDescription>?    // array of packet descriptions for read buffer
    //    var mIsRunning = false
}


//回调函数(Callback)的实现
//void HandleOutputBuffer(aqData: UnsafeMutableRawPointer,
//                    inAQ: AudioQueueRef,
//                    inBuffer: AudioQueueBufferRef){
//    print(inBuffer)
////    BXAudioPlayer* player=(__bridge BXAudioPlayer*)inUserData;
////    [player audioQueueOutputWithQueue:inAQ queueBuffer:buffer];
//}

//func HandleOutputBuffer(userData: UnsafeMutableRawPointer?,
//                        inAQ: AudioQueueRef,
//                        bufferToFill: UnsafeMutablePointer<AudioQueueBuffer>) {
//
//
//
//}

//计算buffer Size
func DeriveBufferSize(inAudioFile: AudioFileID,
                      inDesc: AudioStreamBasicDescription,
                      inSeconds: Double,
                      outBufferSize: UnsafeMutablePointer<UInt32>,
                      outNumPackets: UnsafeMutablePointer<UInt32>) {
    
    // limit size to 16K
    
    //计算最大数据包多大
    var propertySize: UInt32 = UInt32(MemoryLayout<UInt32>.size)
    var maxPacketSize: UInt32 = 0
    AudioFileGetProperty(inAudioFile, kAudioFilePropertyPacketSizeUpperBound, &propertySize, &maxPacketSize)
    
    if inDesc.mFramesPerPacket > 0 {
        
        let numPacketsForTime = UInt32(inDesc.mSampleRate / (Double(inDesc.mFramesPerPacket) * inSeconds))
        //        let numPacketsForTime = UInt32(inDesc.mSampleRate / Double(inDesc.mFramesPerPacket))
        
        outBufferSize.pointee = numPacketsForTime * maxPacketSize
        
    } else {
        // if frames per packet is zero, then the codec has no predictable packet == time
        // so we can't tailor this (we don't know how many Packets represent a time period
        // we'll just return a default buffer size
        outBufferSize.pointee = (maxBufferSize > maxPacketSize ? maxBufferSize : maxPacketSize)
    }
    
    // we're going to limit our size to our default
    if outBufferSize.pointee > maxBufferSize && outBufferSize.pointee > maxPacketSize {
        
        outBufferSize.pointee = maxBufferSize
        
    }
    else {
        // also make sure we're not too small - we don't want to go the disk for too small chunks
        if outBufferSize.pointee < minBufferSize {
            outBufferSize.pointee = minBufferSize
        }
    }
    outNumPackets.pointee = outBufferSize.pointee / maxPacketSize
}

func HandleOutputBuffer(aqData: UnsafeMutableRawPointer?,
                        inAQ: OpaquePointer,
                        inBuffer: UnsafeMutablePointer<AudioQueueBuffer>){
    
    guard let aqData = aqData else {
        return
    }
    
    let player = aqData.assumingMemoryBound(to: AQPlayerState.self)
    
    //
    if player.pointee.mIsRunning { return }
    
    // read audio data from file into supplied buffer
    var numBytes: UInt32 = inBuffer.pointee.mAudioDataBytesCapacity
    var nPackets = player.pointee.mNumPacketsToRead
    
    print("mNumPacketsToRead参数：\(player.pointee.mNumPacketsToRead)")
    
//    只有当需要读取固定时长音频或者非压缩音频时才会用到AudioFileReadPackets
    //按照帧读取音频数据
    Utility.check(error: AudioFileReadPacketData(player.pointee.mAudioFile!,              // AudioFileID
                                                false,                                     // use cache?
                                                &numBytes,                                 // initially - buffer capacity, after - bytes actually read
                                                player.pointee.mPacketDescs,                // pointer to an array of PacketDescriptors
                                                player.pointee.packetPosition,             // index of first packet to be read
                                                &nPackets,                                 // number of packets
                                                inBuffer.pointee.mAudioData),          // output buffer
                      operation: "AudioFileReadPacketData failed")

    
    // enqueue buffer into the Audio Queue
    // if nPackets == 0 it means we are EOF (all data has been read from file)
    if nPackets > 0 {
        inBuffer.pointee.mAudioDataByteSize = numBytes
        
        Utility.check(error: AudioQueueEnqueueBuffer(inAQ,                                                 // queue
                                                     inBuffer,                                          // buffer to enqueue
                                                     (player.pointee.mPacketDescs == nil ? 0 : nPackets),    // number of packet descriptions
                                                     player.pointee.mPacketDescs),                           // pointer to a PacketDescriptions array
                      operation: "AudioQueueEnqueueBuffer failed")
        
        player.pointee.packetPosition += Int64(nPackets)
        
    } else {
        
        //
        Utility.check(error: AudioQueueStop(inAQ, false),
                      operation: "AudioQueueStop failed")
        
        player.pointee.mIsRunning = true
    }
    
}

class ViewController: UIViewController {
    
    
    var aqData = AQPlayerState()
    
    lazy var url: URL = {
        let path = Bundle.main.path(forResource: "music-Loop", ofType: "mp3")
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
        // get the audio data format from the file
        var mDataFormat = AudioStreamBasicDescription()
        //        var mDataFormat:AudioStreamBasicDescription = AudioStreamBasicDescription()
        var dataFormatSize: UInt32 = UInt32(MemoryLayout<AudioStreamBasicDescription>.size)
        AudioFileGetProperty(audioFile,
                             kAudioFilePropertyDataFormat,
                             &dataFormatSize,
                             &mDataFormat)
        print("mDataFormat:\(mDataFormat.mSampleRate)")
        
        //        Thread 1: Simultaneous accesses to 0x1060273a8, but modification requires exclusive access
        //        项目源码违反swift独占性规则，当讲queue改为aq.queue 因此传递的aqData暂时不能包含 asbd和队列
        
        //3、创建播放用的音频队列 create an output (playback) queue
        var mQueue: AudioQueueRef?
        AudioQueueNewOutput(&mDataFormat,
                            HandleOutputBuffer,
                            &aqData,
                            nil,
                            nil,
                            0,
                            &mQueue)
        
        guard let mQueue = mQueue else { return  }

        //4、计算输出缓冲区大小 和 包的数量 audioqueue要查看每个缓冲区大小，因此读取设置
        var bufferByteSize: UInt32 = 0 //放在`aqData`中会引发独占性规则
        DeriveBufferSize(inAudioFile: audioFile,
                         inDesc: mDataFormat,
                         inSeconds: 0.5,
                         outBufferSize: &bufferByteSize,
                         outNumPackets: &aqData.mNumPacketsToRead)
        
        // check if we are dealing with a variable-bit-rate file. ASBDs for VBR files always have
        // mBytesPerPacket and mFramesPerPacket as 0 since they can fluctuate at any time.
        // If we are dealing with a VBR file, we allocate memory to hold the packet descriptions
        if mDataFormat.mBytesPerPacket == 0 || mDataFormat.mFramesPerPacket == 0{
            // variable bit rate formats
            let s = MemoryLayout<AudioStreamPacketDescription>.size
            aqData.mPacketDescs = UnsafeMutablePointer<AudioStreamPacketDescription>.allocate(capacity: s * Int(aqData.mNumPacketsToRead))
        } else {
            // constant bit rate formats (we don't provide packet descriptions, e.g linear PCM)
            aqData.mPacketDescs = nil;
        }
        
        //5、创建分配缓冲空间
        // allocate the buffers
        var buffers = [AudioQueueBufferRef?](repeating: nil, count: maxBufferNum)
        
        for i in 0..<maxBufferNum {
            // allocate a buffer of the specified size in the given queue
            //      places an AudioQueueBufferRef in the buffers array
            AudioQueueAllocateBuffer(mQueue,                               // AudioQueueRef
                                     bufferByteSize,                       // number of bytes to allocate
                                     &buffers[i])
            // manually invoke callback to fill buffers with data
            if let buffer = buffers[i] {
                HandleOutputBuffer(aqData: &aqData,
                                   inAQ: mQueue,
                                   inBuffer: buffer)
            }
            
        }
        
        //开启队列
        AudioQueueStart(mQueue, nil)
        
        // and wait
//        repeat{
//            CFRunLoopRunInMode(CFRunLoopMode.defaultMode, 0.25, false)
//        } while !aqData.mIsRunning
        
        // isDone represents the state of the Audio File enqueuing. This does not mean the
        // Audio Queue is actually done playing yet. Since we have 3 half-second buffers in-flight
        // run for continue to run for a short additional time so they can be processed
//        CFRunLoopRunInMode(CFRunLoopMode.defaultMode, 2, false)
        
        //
    }
    
    func stop()  {
        aqData.mIsRunning = false
        //        AudioQueueStop(, <#T##inImmediate: Bool##Bool#>)
    }
    
}

