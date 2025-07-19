# FSM

`FSM` is a lightweight Swift library that brings finite-state machine capabilities to your projects. Model deterministic transitions with minimal code and receive delegate callbacks whenever the state changes.

## Highlights

- Clean API for defining states and events.
- Delegate hooks for pre- and post-transition logic.
- Helpers to persist and restore the current state.

## Installation

Add `FSM` to your `Package.swift` dependencies:

```swift
.package(url: "https://github.com/yourusername/FSM.git", from: "1.0.0")
```

Then include `"FSM"` in the dependencies list of your targets.

## Example

```swift
import FSM

final class ContentViewModel: NSObject {
    private let fsm: FSM

    override init() {
        let transitions = [
            Transition(from: "1", to: "2", event: "event1"),
            Transition(from: "2", to: "3", event: "event2"),
            Transition(from: "3", to: "1", event: "event3")
        ]

        fsm = FSM(transitions: transitions, initialState: "1")
        super.init()

        fsm.delegate = self
        fsm.send("event1")
        fsm.send("event2")
        fsm.send("event3")
        print(fsm.stateValue())  // -> "1"
    }
}

extension ContentViewModel: FSMDelegate {
    func stateWillChange(from oldState: FSMState, to newState: FSMState) {
        print("Will transition from \(oldState) to \(newState)")
    }

    func stateDidChange(from oldState: FSMState, to newState: FSMState) {
        print("Did transition from \(oldState) to \(newState)")
    }
}
```

## License

Released under the [MIT License](LICENSE).
