import UIKit
import Foundation
import PlaygroundSupport
@testable import SwiftIconFont
@testable import JTAppleCalendar

class ADVDayCell : JTAppleDayCell {
    var label: UILabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("DayCell init with coder is not implemented.")
    }
    
    func loadView() {
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(label)
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
    }
}

class ADVCalendarViewController : UIViewController, JTAppleCalendarViewDataSource, JTAppleCalendarViewDelegate {
    init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        
        print("ADVCalendarViewController init wih frame: ", frame)
        
        self.view = UIView(frame: frame)
        self.view.backgroundColor = UIColor.green
        
        let margins = self.view.layoutMarginsGuide
        
        let calendar = JTAppleCalendarView()
        print("CalendarView frame: ", calendar.frame)
        calendar.dataSource = self
        calendar.delegate = self
        calendar.cellInset = CGPoint(x: 0, y: 0)
        calendar.backgroundColor = UIColor.white
        calendar.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(calendar)
        calendar.topAnchor.constraint(equalTo: margins.topAnchor).isActive = true
        calendar.leadingAnchor.constraint(equalTo: margins.leadingAnchor).isActive = true
        calendar.trailingAnchor.constraint(equalTo: margins.trailingAnchor).isActive = true
        //calendar.widthAnchor.constraint(equalTo: margins.widthAnchor).isActive = true
        //calendar.heightAnchor.constraint(equalToConstant: 400).isActive = true */
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd MM yyyy"
        
        let startDate = formatter.date(from: "21 10 2016")!
        let endDate = Date()
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate, numberOfRows: 6, calendar: Calendar.current, generateInDates: InDateCellGeneration.forAllMonths, generateOutDates: OutDateCellGeneration.tillEndOfGrid, firstDayOfWeek: DaysOfWeek.sunday, hasStrictBoundaries: true)
        
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplayCell cell: JTAppleDayCellView, date: Date, cellState: CellState) {
        let advCalendarCell = cell as! ADVDayCell
        advCalendarCell.label.text = cellState.text
    }
}

// cell design

let screen = CGRect(x: 0, y: 0, width: 414, height: 736) // iphone 7 plus

let viewCtrl = ADVCalendarViewController(frame: screen)
let view = viewCtrl.view

// play!

PlaygroundPage.current.liveView = view
PlaygroundPage.current.needsIndefiniteExecution = true
