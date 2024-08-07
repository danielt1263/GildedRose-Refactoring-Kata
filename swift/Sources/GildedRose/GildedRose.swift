public class GildedRose {
    var items: [Item]
    private let updatedSellIns: [String: (Int) -> Int]
    private let updatedQualities: [String: (Int, Int) -> Int]

    public init(items: [Item]) {
        self.items = items
        updatedSellIns = [
            "Sulfuras, Hand of Ragnaros": { $0 }
        ]
        updatedQualities = [
            "Aged Brie": updatedAgedBrieQuality,
            "Backstage passes to a TAFKAL80ETC concert": updatedPassesQuality,
            "Conjured": updatedQuality(byFactor: 2),
            "Sulfuras, Hand of Ragnaros": { $1 },
        ]
    }

    public func updateQuality() {
        for each in items {
            let sellIn = (updatedSellIns[each.name] ?? updatedSellIn)(each.sellIn)
            let quality = (updatedQualities[each.name] ?? updatedQuality(byFactor: 1))(each.sellIn, each.quality)
            each.sellIn = sellIn
            each.quality = quality
        }
    }
}

func updatedSellIn(sellIn: Int) -> Int {
    sellIn - 1
}

func updatedQuality(byFactor factor: Int) -> (Int, Int) -> Int {
    { sellIn, quality in
        guard quality > 0 else { return quality }
        if sellIn > 0 {
            return max(quality - 1 * factor, 0)
        } else {
            return max(quality - 2 * factor, 0)
        }
    }
}

// custom qualities
func updatedAgedBrieQuality(sellIn: Int, quality: Int) -> Int {
    guard quality < 50 else { return quality }
    if sellIn > 0 {
        return quality + 1
    } else {
        return min(quality + 2, 50)
    }
}

func updatedPassesQuality(sellIn: Int, quality: Int) -> Int {
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
}
