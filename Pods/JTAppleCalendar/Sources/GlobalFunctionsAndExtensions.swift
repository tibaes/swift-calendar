//
//  GlobalFunctionsAndExtensions.swift
//  Pods
//
//  Created by JayT on 2016-06-26.
//
//

func delayRunOnMainThread(_ delay: Double, closure: @escaping () -> ()) {
    DispatchQueue.main.asyncAfter(
        deadline: DispatchTime.now() +
            Double(Int64(delay * Double(NSEC_PER_SEC))) /
            Double(NSEC_PER_SEC), execute: closure)
}

func delayRunOnGlobalThread(_ delay: Double,
                            qos: DispatchQoS.QoSClass,
                            closure: @escaping () -> ()) {
    DispatchQueue.global(qos: qos).asyncAfter(
        deadline: DispatchTime.now() +
            Double(Int64(delay * Double(NSEC_PER_SEC))) /
            Double(NSEC_PER_SEC), execute: closure
    )
}

extension Calendar {
    static let formatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy MM dd"
        return dateFormatter
    }()
    

    func startOfMonth(for date: Date) -> Date? {
        guard let comp = dateFormatterComponents(from: date) else { return nil }
        return Calendar.formatter.date(from: "\(comp.year) \(comp.month) 01")
    }
    
    func endOfMonth(for date: Date) -> Date? {
        guard
            let comp = dateFormatterComponents(from: date),
            let day = self.range(of: .day, in: .month, for: date)?.count else {
                return nil
        }
        
        return Calendar.formatter.date(from: "\(comp.year) \(comp.month) \(day)")
    }
    
    private func dateFormatterComponents(from date: Date) -> (month: Int, year: Int)? {
        
        // Setup the dateformatter to this instance's settings
        Calendar.formatter.timeZone = self.timeZone
        Calendar.formatter.locale = self.locale
        
        let comp = self.dateComponents([.year, .month], from: date)
        
        guard
            let month = comp.month,
            let year = comp.year else {
                return nil
        }
        return (month, year)
    }
}

extension Dictionary where Value: Equatable {
    func key(for value: Value) -> Key? {
        guard let index = index(where: { $0.1 == value }) else {
            return nil
        }
        return self[index].0
    }
}
