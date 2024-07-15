@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    func testProperties() {
        propertyTest(refItems: [])
        for name in String.names {
            for sellIn in Int.sellIns {
                for quality in Int.qualities {
                    let refItems = [Item(name: name, sellIn: sellIn, quality: quality)]
                    propertyTest(refItems: refItems)
                }
            }
        }
    }

    func propertyTest(refItems: [Item]) {
        let sutItems = refItems.map { Item(name: $0.name, sellIn: $0.sellIn, quality: $0.quality) }

        print("🟢", refItems)
        let ref = GildedRose(items: refItems)
        ref.updateQuality()
        print("🟣", ref.items)

        let sut = GildedRoseʹ(items: sutItems)
        sut.updateQuality()

        assert(sut.items.count == ref.items.count)
        assert(sut.items.map(\.name) == ref.items.map(\.name))
        assert(sut.items.map(\.sellIn) == ref.items.map(\.sellIn))
        //assert(sut.items.map(\.quality) == ref.items.map(\.quality))
    }

    func test_decrement_sellIn() {
        let items = [Item(name: "", sellIn: Int.min + 1, quality: Int.min)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.sellIn), [Int.min])
    }

    func test_sellIn_unchanged_for_sulfuras() {
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: Int.min + 1, quality: Int.min)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.sellIn), [Int.min + 1])
    }
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
