@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    func testProperties() {
        for _ in (0 ..< 100000) {
            propertyTest()
        }
    }

    func propertyTest() {
        let refItems = Array.items.randomElement()!
        let sutItems = refItems.map { Item(name: $0.name, sellIn: $0.sellIn, quality: $0.quality) }

        let ref = GildedRose(items: refItems)
        ref.updateQuality()

        let sut = GildedRoseʹ(items: sutItems)
        sut.updateQuality()

        XCTAssertEqual(sut.items.count, ref.items.count)
        XCTAssertEqual(sut.items.map(\.name), ref.items.map(\.name))
        XCTAssertEqual(sut.items.map(\.sellIn), ref.items.map(\.sellIn))
        XCTAssertEqual(sut.items.map(\.quality), ref.items.map(\.quality))
    }
}

extension Array where Element == Item {
    static let items = [
        [],
        [
            Item(name: String.names.randomElement()!, sellIn: Int.sellIns.randomElement()!, quality: Int.qualities.randomElement()!)
        ],
        [
            Item(name: String.names.randomElement()!, sellIn: Int.sellIns.randomElement()!, quality: Int.qualities.randomElement()!),
            Item(name: String.names.randomElement()!, sellIn: Int.sellIns.randomElement()!, quality: Int.qualities.randomElement()!)
        ],
    ]
}

extension String {
    static let names = [
        "",
        "Aged Brie",
        "Backstage passes to a TAFKAL80ETC concert",
        "Sulfuras, Hand of Ragnaros",
    ]
}

extension Int {
    static let sellIns = [
        Int.min + 1,
        -1,
        0,
        1,
        5,
        6,
        7,
        10,
        11,
        12,
        Int.max
    ]

    static let qualities = [
        Int.min,
        -1,
        0,
        1,
        49,
        50,
        51,
        Int.max
    ]
}
