//
//  FSM.swift
//  FSM
//
//  Created by hong on 6/27/25.
//

import Foundation

public typealias FSMState = String

public typealias FSMEvent = String


public struct Transition {
    let from: FSMState
    let to: FSMState
    let event: FSMEvent
    
    public init(from: FSMState, to: FSMState, event: FSMEvent) {
        self.from = from
        self.to = to
        self.event = event
    }
}

// Define a protocol for FSM delegate
public protocol FSMDelegate: AnyObject {
    func stateWillChange(from oldState: FSMState, to newState: FSMState)
    func stateDidChange(from oldState: FSMState, to newState: FSMState)
}

/// Finite-state machine https://en.wikipedia.org/wiki/Finite-state_machine
public class FSM {
    
    private let initialState: FSMState
    private let transitions: [Transition]
    private(set) var currentState: FSMState
    
    // Add a delegate property
    public weak var delegate: FSMDelegate?
    
    // 初始化状态机
    public init(transitions: [Transition], initialState: FSMState) {
        self.transitions = transitions
        self.initialState = initialState
        self.currentState = initialState
    }
    
    // 处理事件
    public func send(_ event: FSMEvent) {
        for transition in transitions {
            if currentState == transition.from && event == transition.event {
                delegate?.stateWillChange(from: currentState, to: transition.to)
                let previousState = currentState
                currentState = transition.to
                delegate?.stateDidChange(from: previousState, to: currentState)
                break
            }
        }
    }
    
    // 获取持久化状态字符串
    public func persistenceStateJsonString() -> String {
        return currentState
    }
    
    // 从持久化恢复状态
    public func resume(from jsonStr: String) {
        currentState = jsonStr
    }
    
    // 强制跳转状态
    public func forceChangeState(to newState: FSMState) {
        currentState = newState
    }
    
    // 获取当前状态
    public func stateValue() -> FSMState {
        return currentState
    }
    
    // 重置状态机
    public func reset() {
        currentState = initialState
    }
}
