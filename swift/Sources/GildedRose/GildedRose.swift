public class GildedRose {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public func updateQuality() {
        for i in 0 ..< items.count {
            if items[i].name != "Aged Brie" && items[i].name != "Backstage passes to a TAFKAL80ETC concert" {
                if items[i].quality > 0 {
                    if items[i].name != "Sulfuras, Hand of Ragnaros" {
                        items[i].quality = items[i].quality - 1
                    }
                }
            } else {
                if items[i].quality < 50 {
                    items[i].quality = items[i].quality + 1

                    if items[i].name == "Backstage passes to a TAFKAL80ETC concert" {
                        if items[i].sellIn < 11 {
                            if items[i].quality < 50 {
                                items[i].quality = items[i].quality + 1
                            }
                        }

                        if items[i].sellIn < 6 {
                            if items[i].quality < 50 {
                                items[i].quality = items[i].quality + 1
                            }
                        }
                    }
                }
            }

            if items[i].name != "Sulfuras, Hand of Ragnaros" {
                items[i].sellIn = items[i].sellIn - 1
            }

            if items[i].sellIn < 0 {
                if items[i].name != "Aged Brie" {
                    if items[i].name != "Backstage passes to a TAFKAL80ETC concert" {
                        if items[i].quality > 0 {
                            if items[i].name != "Sulfuras, Hand of Ragnaros" {
                                items[i].quality = items[i].quality - 1
                            }
                        }
                    } else {
                        items[i].quality = items[i].quality - items[i].quality
                    }
                } else {
                    if items[i].quality < 50 {
                        items[i].quality = items[i].quality + 1
                    }
                }
            }
        }
    }
}

public class GildedRoseʹ {
    var items: [Item]

    public init(items: [Item]) {
        self.items = items
    }

    public func updateQuality() {
        for each in items {
            let sellIn = updatedSellIn(name: each.name, sellIn: each.sellIn)
            let quality = updatedQuality(name: each.name, sellIn: each.sellIn, quality: each.quality)
            each.sellIn = sellIn
            each.quality = quality
        }
    }
}

func updatedSellIn(name: String, sellIn: Int) -> Int {
    guard name != "Sulfuras, Hand of Ragnaros" else {
        return sellIn
    }
    return sellIn - 1
}

func updatedQuality(name: String, sellIn: Int, quality: Int) -> Int {
    if name == "Aged Brie" && quality < 51 {
        return min(quality + 2, 50)
    }
    if name == "Aged Brie" && quality > 50 || quality < 1 {
        return quality
    }
    if sellIn > 0 {
        return quality - 1
    } else {
        return max(quality - 2, 0)
    }
}
