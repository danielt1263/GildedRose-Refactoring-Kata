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
        assert(sut.items.map(\.quality) == ref.items.map(\.quality))
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

    func test_decrement_quality() {
        let items = [Item(name: "", sellIn: Int.min + 1, quality: 1)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_only_decrement_quality_if_greater_than_0() {
        let items = [Item(name: "", sellIn: Int.min + 1, quality: -1)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [-1])
    }

    func test_decrement_quality_by_2_or_to_0() {
        let items = [Item(name: "", sellIn: Int.min + 1, quality: 49)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [47])
    }

    func test_decrement_quality_by_1_if_sellIn_greater_than_0() {
        let items = [Item(name: "", sellIn: 1, quality: 49)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [48])
    }

    func test_increment_quality_by_2_for_brie() {
        let items = [Item(name: "Aged Brie", sellIn: Int.min + 1, quality: Int.min)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [Int.min + 2])
    }

    func test_brie_quality_max_50() {
        let items = [Item(name: "Aged Brie", sellIn: Int.min + 1, quality: 49)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [50])
    }

    func test_only_increment_brie_quality_under_50() {
        let items = [Item(name: "Aged Brie", sellIn: Int.min + 1, quality: 51)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [51])
    }

    func test_increment_brie_by_1_if_sellIn_greater_than_0() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: Int.min)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [Int.min + 1])
    }

    func test_brie_quality_max_50_sellIn_over_0() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 50)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [50])
    }

    func test_passes_quality_0() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: Int.min + 1, quality: Int.min)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_pass_quality_plus_3_if_sellIn_greater_than_0() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: Int.min)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [Int.min + 3])
    }

    func test_pass_quality_0_if_sell_in_equal_to_0() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 49)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_pass_ignore_quality_less_than_50() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: 51)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [51])
    }

    func test_pass_dont_ignore_quality_equal_to_50() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: Int.min + 1, quality: 50)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_pass_sellIn_less_than_0_always_drops_quaility() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: Int.min + 1, quality: 51)]
        let sut = GildedRoseʹ(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
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
