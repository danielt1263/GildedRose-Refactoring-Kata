public class GildedRose {
    var items: [Item]
    private let updatedSellIns: [String: (Int) -> Int]
    public init(items: [Item]) {
        self.items = items
        updatedSellIns = [
            "Sulfuras, Hand of Ragnaros": { $0 }
        ]
    }

    public func updateQuality() {
        for each in items {
            let sellIn = (updatedSellIns[each.name] ?? updatedSellIn)(each.sellIn)
            let quality = updatedQuality(name: each.name, sellIn: each.sellIn, quality: each.quality)
            each.sellIn = sellIn
            each.quality = quality
        }
    }
}

func updatedSellIn(sellIn: Int) -> Int {
    sellIn - 1
}

func updatedQuality(name: String, sellIn: Int, quality: Int) -> Int {
    switch name {
    case "Aged Brie":
        guard quality < 50 else { return quality }
        if sellIn > 0 {
            return quality + 1
        } else {
            return min(quality + 2, 50)
        }
    case "Backstage passes to a TAFKAL80ETC concert":
        guard sellIn > 0 else { return 0 }
        guard quality <= 50 else { return quality }
        if sellIn > 10 {
            return min(quality + 1, 50)
        } else if sellIn > 5 {
            return min(quality + 2, 50)
        } else if sellIn > 0 {
            return min(quality + 3, 50)
        } else {
            return quality + 2
        }
    case "Sulfuras, Hand of Ragnaros":
        return quality
    default:
        guard quality > 0 else { return quality }
        if sellIn > 0 {
            return quality - 1
        } else {
            return max(quality - 2, 0)
        }
    }
}
