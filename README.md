# FSM

A **finite-state machine** (**FSM**) or **finite-state automaton** (**FSA**, plural: *automata*), **finite automaton**, or simply a **state machine**, is a mathematical [model of computation](https://en.wikipedia.org/wiki/Model_of_computation). It is an [abstract machine](https://en.wikipedia.org/wiki/Abstract_machine) that can be in exactly one of a finite number of *[states](https://en.wikipedia.org/wiki/State_(computer_science))* at any given time. The FSM can change from one state to another in response to some [inputs](https://en.wikipedia.org/wiki/Input_(computer_science)); the change from one state to another is called a *transition*.[[1\]](https://en.wikipedia.org/wiki/Finite-state_machine#cite_note-1) An FSM is defined by a list of its states, its initial state, and the inputs that trigger each transition. Finite-state machines are of two types—[deterministic finite-state machines](https://en.wikipedia.org/wiki/Deterministic_finite_automaton) and [non-deterministic finite-state machines](https://en.wikipedia.org/wiki/Nondeterministic_finite_automaton).[[2\]](https://en.wikipedia.org/wiki/Finite-state_machine#cite_note-2) For any non-deterministic finite-state machine, an equivalent deterministic one can be constructed.



# Usage

```Swift
import FSM

class ContentViewModel: NSObject {
    
    private let fsm: FSM
    
    override init() {
        
        let trans = [
            Transition(from: "1", to: "2", event: "event1"),
            Transition(from: "2", to: "3", event: "event2"),
            Transition(from: "3", to: "1", event: "event3"),
        ]
        
        let fsm = FSM(transitions: trans, initialState: "1")
        self.fsm = fsm
        super.init()
        fsm.delegate = self
        fsm.send("event1")
        fsm.send("event2")
        fsm.send("event3")
        print(fsm.stateValue())
    }
}

extension ContentViewModel: FSMDelegate {
    func stateWillChange(from oldState: FSMState, to newState: FSMState) {
        
    }
    
    func stateDidChange(from oldState: FSMState, to newState: FSMState) {
        
    }
}
```

