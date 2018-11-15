import UIKit

extension Float {
  var description: String {
    return self.truncatingRemainder(dividingBy: 1) == 0 ? String(format: "%.0f", self) : String(self)
  }
}

struct Item {
  let barcode: String
  let name: String
  let unit: String
  let price: Float
}

protocol Promotion {
  var type: PromotionType { get }
  var barcodes: [String] { get }
  
  func apply(cart: Cart)
}

enum PromotionType {
  case buy(_ count: Float, getFree: Float)
}

struct BuyTwoGetOneFreePromotion: Promotion {
  var type: PromotionType = .buy(2, getFree: 1)
  var barcodes: [String]
  
  init(barcodes: [String]) {
    self.barcodes = barcodes
  }
  
  func apply(cart: Cart) {
    cart.itemsCount.forEach {
      if barcodes.contains($0.key) {
        cart.applyDiscount(with: $0.key, count: Float(Int($0.value / 2)))
      }
    }
  }
}

func loadAllItems() -> [Item] {
  return [
    Item(
      barcode: "ITEM000000",
      name: "可口可乐",
      unit: "瓶",
      price: 3.00
    ),
    Item(
      barcode: "ITEM000001",
      name: "雪碧",
      unit: "瓶",
      price: 3.00
    ),
    Item(
      barcode: "ITEM000002",
      name: "苹果",
      unit: "斤",
      price: 5.50
    ),
    Item(
      barcode: "ITEM000003",
      name: "荔枝",
      unit: "斤",
      price: 15.00
    ),
    Item(
      barcode: "ITEM000004",
      name: "电池",
      unit: "个",
      price: 2.00
    ),
    Item(
      barcode: "ITEM000005",
      name: "方便面",
      unit: "袋",
      price: 4.50
    )
  ]
}

func loadPromotions() -> [Promotion] {
  return [
    BuyTwoGetOneFreePromotion(barcodes: ["ITEM000000", "ITEM000001", "ITEM000005"])
  ]
}

class ItemRepository {
  var items: [Item] {
    return loadAllItems()
  }

  func find(by barcode: String) -> Item? {
    return items.filter { $0.barcode == barcode }.first
  }
}

class Cart {
  private(set) var itemsCount = [String: Float]()
  private(set) var itemsDiscount = [String: Float]()
  
  private let itemPepository: ItemRepository
  
  init(itemRepository: ItemRepository = .init(), barcodes: [String]) {
    self.itemPepository = itemRepository
    barcodes
      .map { $0.split(separator: "-").map(String.init) }
      .map { components -> (barcode: String, count: Float) in
        if components.count == 2 {
          return (components[0], Float(components[1]) ?? 1.0)
        } else {
          return (components[0], 1.0)
        }
      }.forEach {
        self.addToCart(with: $0.barcode, count: $0.count)
      }
  }

  func addToCart(with barcode: String, count: Float) {
    itemsCount[barcode] = (itemsCount[barcode] ?? 0) + count
  }

  func applyDiscount(with barcode: String, count: Float) {
    itemsDiscount[barcode] = (itemsDiscount[barcode] ?? 0) + count
  }

  func generateReceipts() -> String {
    let title = "***<没钱赚商店>收据***"
    let itemsInformation = itemPepository.items.filter { itemsCount.keys.contains($0.barcode) }.map { information(for: $0) }.joined(separator: "\n")
    let divider = "----------------------"
    let total = "总计：\(String(format: "%.2f", totol()))(元)"
    let totalDiscount = "节省：\(String(format: "%.2f", totolDiscount()))(元)"
    let end = "**********************"
    let receipts = [title, itemsInformation, divider, total, totalDiscount, end].joined(separator: "\n")
    return receipts
  }

  private func totolDiscount() -> Float {
    return itemsDiscount.reduce(Float(0)) { (result, itemDiscount) -> Float in
      guard let item = self.itemPepository.find(by: itemDiscount.key) else {
        return result
      }
      return result + item.price * itemDiscount.value
    }
  }
  
  private func totol() -> Float {
    return itemsCount.reduce(Float(0)) { (result, itemCount) -> Float in
      guard let item = self.itemPepository.find(by: itemCount.key) else {
        return result
      }
      return result + item.price * itemCount.value
    } - totolDiscount()
  }
  
  private func information(for item: Item) -> String {
    guard let count = itemsCount[item.barcode] else {
        return "\n"
    }
    let discount = itemsDiscount[item.barcode] ?? 0
    return "名称：\(item.name)，数量：\(count.description)\(item.unit)，单价：\(String(format: "%.2f", item.price))(元)，小计：\((count - discount) * item.price)(元)"
  }
}

func applyPromotions(promotions: [Promotion], for cart: Cart) -> Cart {
  promotions.forEach { $0.apply(cart: cart) }
  return cart
}

let purchasedBarcodes = [
  "ITEM000001",
  "ITEM000001",
  "ITEM000001",
  "ITEM000001",
  "ITEM000001",
  "ITEM000003-2",
  "ITEM000005",
  "ITEM000005",
  "ITEM000005"
]

let expectedRecept = """
***<没钱赚商店>收据***
名称：雪碧，数量：5瓶，单价：3.00(元)，小计：9.0(元)
名称：荔枝，数量：2斤，单价：15.00(元)，小计：30.0(元)
名称：方便面，数量：3袋，单价：4.50(元)，小计：9.0(元)
----------------------
总计：48.00(元)
节省：10.50(元)
**********************
"""
let receipt = applyPromotions(promotions: loadPromotions(), for: Cart(barcodes: purchasedBarcodes)).generateReceipts()
print(receipt)
print("\n结果：" + (receipt == expectedRecept ? "正确✔️" : "错误❌"))

