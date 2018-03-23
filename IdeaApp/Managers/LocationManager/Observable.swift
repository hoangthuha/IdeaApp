class Observable<T> {
    
    let didChange = Event<(T, T)>()
    fileprivate var value: T
    
    init(_ initialValue: T) {
        value = initialValue
    }
    
    func set(_ newValue: T) {
        let oldValue = value
        value = newValue
        didChange.raise((oldValue, newValue))
    }
    
    func get() -> T {
        return value
    }
}
