@testable import GildedRose
import XCTest

class GildedRoseTests: XCTestCase {
    func test_decrement_sellIn() {
        let items = [Item(name: "", sellIn: Int.min + 1, quality: Int.min)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.sellIn), [Int.min])
    }

    func test_sellIn_unchanged_for_sulfuras() {
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: Int.min + 1, quality: Int.min)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.sellIn), [Int.min + 1])
    }

    func test_decrement_quality() {
        let items = [Item(name: "", sellIn: Int.min + 1, quality: 1)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_only_decrement_quality_if_greater_than_0() {
        let items = [Item(name: "", sellIn: Int.min + 1, quality: -1)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [-1])
    }

    func test_decrement_quality_by_2_or_to_0() {
        let items = [Item(name: "", sellIn: Int.min + 1, quality: 49)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [47])
    }

    func test_decrement_quality_by_1_if_sellIn_greater_than_0() {
        let items = [Item(name: "", sellIn: 1, quality: 49)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [48])
    }

    func test_increment_quality_by_2_for_brie() {
        let items = [Item(name: "Aged Brie", sellIn: Int.min + 1, quality: Int.min)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [Int.min + 2])
    }

    func test_brie_quality_max_50() {
        let items = [Item(name: "Aged Brie", sellIn: Int.min + 1, quality: 49)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [50])
    }

    func test_only_increment_brie_quality_under_50() {
        let items = [Item(name: "Aged Brie", sellIn: Int.min + 1, quality: 51)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [51])
    }

    func test_increment_brie_by_1_if_sellIn_greater_than_0() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: Int.min)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [Int.min + 1])
    }

    func test_brie_quality_max_50_sellIn_over_0() {
        let items = [Item(name: "Aged Brie", sellIn: 1, quality: 50)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [50])
    }

    func test_passes_quality_0() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: Int.min + 1, quality: Int.min)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_pass_quality_plus_3_if_sellIn_greater_than_0() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: Int.min)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [Int.min + 3])
    }

    func test_pass_quality_0_if_sell_in_equal_to_0() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 0, quality: 49)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_pass_ignore_quality_less_than_50() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 1, quality: 51)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [51])
    }

    func test_pass_dont_ignore_quality_equal_to_50() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: Int.min + 1, quality: 50)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_pass_sellIn_less_than_0_always_drops_quaility() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: Int.min + 1, quality: 51)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_pass_quality_plus_2_if_sellIn_greater_than_5() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: Int.min)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [Int.min + 2])
    }

    func test_pass_quality_max_50() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 6, quality: 49)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [50])
    }

    func test_pass_quality_plus_1_if_sellIn_greater_than_10() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: Int.min)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [Int.min + 1])
    }

    func test_pass_max_quailty_50_if_sellIn_greater_than_10() {
        let items = [Item(name: "Backstage passes to a TAFKAL80ETC concert", sellIn: 11, quality: 50)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [50])
    }

    func test_sulfuras_quality_unchanged() {
        let items = [Item(name: "Sulfuras, Hand of Ragnaros", sellIn: Int.min + 1, quality: 1)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [1])
    }

    func test_conjured_decrement_quality() {
        let items = [Item(name: "Conjured", sellIn: Int.min + 1, quality: 1)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [0])
    }

    func test_conjured_only_decrement_quality_if_greater_than_0() {
        let items = [Item(name: "Conjured", sellIn: Int.min + 1, quality: -1)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [-1])
    }

    func test_conjured_decrement_quality_by_2_or_to_0() {
        let items = [Item(name: "Conjured", sellIn: Int.min + 1, quality: 49)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [45])
    }

    func test_conjured_decrement_quality_by_1_if_sellIn_greater_than_0() {
        let items = [Item(name: "Conjured", sellIn: 1, quality: 49)]
        let sut = GildedRose(items: items)
        sut.updateQuality()
        XCTAssertEqual(sut.items.map(\.quality), [47])
    }

    func test_conjured_dont_decrement_below_0() {
        let items = [Item(name: "Conjured", sellIn: 1, quality: 1)]
        let sut = GildedRose(items: items)
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
