//
//  Model.swift
//  expandTableViewCell
//
//  Created by Andrei Volkau on 13.01.2021.
//

import Foundation

protocol SectionProtocol {
    var title: String { get }
}
protocol RowProtocol {
    var title: String { get }
}

class Parent: SectionProtocol {
    var title: String
    init(title: String) {
        self.title = title
    }
}

class Children: RowProtocol {
    var title: String
    init(title: String) {
        self.title = title
    }
}

class List<Parent: SectionProtocol, Children: RowProtocol> {
    var parent: Parent
    var children: [Children]
    
    init(parent: Parent, children: [Children]) {
        self.parent = parent
        self.children = children
    }
}

var listOfTitles = [
    Parent(title: "Where to go"),
    Parent(title: "When to visit"),
    Parent(title: "How to pay"),
    Parent(title: "About the app")
]
var listOfChildren = [
    [Children(title:"Rome is the capital city and a special comune of Italy (named Comune di Roma Capitale), as well as the capital of the Lazio region. The city has been a major human settlement for almost three millennia. With 2,860,009 residents in 1,285 km2 (496.1 sq mi), it is also the country's most populated comune. It is the third most populous city in the European Union by population within city limits. It is the centre of the Metropolitan City of Rome, which has a population of 4,355,725 residents, thus making it the most populous metropolitan city in Italy. Its metropolitan area is the third-most populous within Italy. Rome is located in the central-western portion of the Italian Peninsula, within Lazio (Latium), along the shores of the Tiber. Vatican City (the smallest country in the world) is an independent country inside the city boundaries of Rome, the only existing example of a country within a city; for this reason Rome has sometimes been defined as the capital of two states."),
     Children(title:"Milan is a city in northern Italy, capital of Lombardy, and the second-most populous city in Italy after Rome. Milan served as the capital of the Western Roman Empire, the Duchy of Milan and the Kingdom of Lombardy–Venetia. The city proper has a population of about 1.4 million while its metropolitan city has 3.26 million inhabitants. Its continuously built-up urban area, that stretches well beyond the boundaries of the administrative metropolitan city, is the fourth largest in the EU with 5.27 million inhabitants. The population within the wider Milan metropolitan area, also known as Greater Milan, is estimated at 8.2 million, making it by far the largest metropolitan area in Italy and the 3rd largest in the EU.")
    ],
    [Children(title: "The best time to visit Rome is from October to April when most of the tourist crowds have dissipated and room rates are lower. Although you'll need a warm coat, weather this time of year hardly ever dips below freezing. For warmer weather – without throngs of tourists and the sweltering humidity – come in May or September. High average temperatures flit between the mid-70s and the lower 80s.")
    ],
    [Children(title: "You can pay with Google Pay wherever you see either the contactless or Google Pay symbols. Look for them on the payment terminal screen or on the cash register at checkout.")
    ],
    [Children(title: "A mobile application, also referred to as a mobile app or simply an app, is a computer program or software application designed to run on a mobile device such as a phone, tablet, or watch. Apps were originally intended for productivity assistance such as email, calendar, and contact databases, but the public demand for apps caused rapid expansion into other areas such as mobile games, factory automation, GPS and location-based services, order-tracking, and ticket purchases, so that there are now millions of apps available. Apps are generally downloaded from application distribution platforms which are operated by the owner of the mobile operating system, such as the App Store (iOS) or Google Play Store. Some apps are free, and others have a price, with the profit being split between the application's creator and the distribution platform. Mobile applications often stand in contrast to desktop applications which are designed to run on desktop computers, and web applications which run in mobile web browsers rather than directly on the mobile device.")
    ]
]

var listOfItems: [List<Parent, Children>] = {
    var list: [List<Parent, Children>] = []
    
    for i in 0..<listOfTitles.count {
        list.append(List(parent: listOfTitles[i], children: listOfChildren[i]))
    }
    return list
}()
