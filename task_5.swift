/*
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
 */


class Car {
    let brand: String
    let productionYear: Int
    var engine: EngineStatus = .off
    var windows: WindowsStatus = .closed // cв-ва класса
    
    enum EngineStatus: CustomStringConvertible { // перечисления с использованием протокола
        case on, off
        
        var description: String {
            switch self {
            case .on:
                return "Двигатель заведён"
            case .off:
                return "Двигатель заглушен"
            }
        }
    }
    
    enum WindowsStatus: CustomStringConvertible {
        case opened, closed
        
        var description: String {
            switch self {
            case .opened:
                return "Окна открыты"
            case .closed:
                return "Окна закрыты"
            }
        }
    }
    
    enum TruckBodyType: CustomStringConvertible {
        case box, tank, refrigerator
        
        var description: String {
            switch self {
            case .box:
                return "Стандартный кузов"
            case .tank:
                return "Цистерна"
            case .refrigerator:
                return "Холодильная камера"
            }
        }
    }
    
    enum Action { // общее перечисление
        case switchEngine(EngineStatus)
        case switchWindows(WindowsStatus)
        case loadCargo(Double)
        case attachTruckBody(TruckBodyType)
        case replaceTyres
    }
    
    
    init(brand: String, productionYear:Int) { // иницилизируем параметры
        self.brand = brand
        self.productionYear = productionYear
    }
    
    func perform(action: Action) {
    }
}

class TrunkCar: Car, CustomStringConvertible {
    
    static var typeEmoji = "🚛" // создаем параметры
    let maxCargoSpace: Double
    var currentCargoSpace: Double = 0
    var body: TruckBodyType?
    
    var description: String {
        let bodyDescription = body?.description ?? "Отцеплен"
        
        return "\(TrunkCar.typeEmoji) \(brand)\nГод выпуска: \(productionYear)\nКузов: \(bodyDescription) \(currentCargoSpace)/\(maxCargoSpace)\nСостояние: \(engine) | \(windows)\n"
    }
    
    init(brand: String, productionYear:Int, maxCargoSpace:Double, body:TruckBodyType?) {
        self.body = body
        self.maxCargoSpace = maxCargoSpace
        super.init(brand: brand, productionYear: productionYear)
    }
    
    override func perform(action: Action) {
        switch action {
        case .switchEngine(let status):
            engine = status
        case .switchWindows(let status):
            windows = status
        case .loadCargo(let load):
            guard body != nil else {
                return
            }
            let expectedLoad = load + currentCargoSpace
            switch expectedLoad {
            case _ where expectedLoad > maxCargoSpace:
                currentCargoSpace = maxCargoSpace
            case _ where expectedLoad < 0:
                currentCargoSpace = 0
            default:
                currentCargoSpace += load
            }
        case .attachTruckBody(let newBody):
            self.body = newBody
            currentCargoSpace = 0
        default:
            break
        }
    }
}

class SportCar: Car, CustomStringConvertible {
    var typeEmoji = "🚗"
    var zeroToHundredAcceleration: Double = 0.0
    var topSpeed: Int = 0
    
    var description: String {
        return "\(typeEmoji) \(brand)\nГод выпуска: \(productionYear)\nРазгон 0–100 км/ч: \(zeroToHundredAcceleration) с\nМаксимальная скорость: \(topSpeed) км/ч\nСостояние: \(engine) | \(windows)\n"
    }
    
    init(brand: String, productionYear:Int, zeroToHundredAcceleration:Double, topSpeed: Int) {
        self.zeroToHundredAcceleration = zeroToHundredAcceleration
        self.topSpeed = topSpeed
        super.init(brand: brand, productionYear: productionYear)
    }
    
    
    override func perform(action: Action) {
        switch action {
        case .switchEngine(let status):
            engine = status
        case .switchWindows(let status):
            windows = status
        case .replaceTyres:
            print("Произведена замена шин!")
        default:
            break
        }
    }
}

var manTruck = TrunkCar(brand: "MAN LION PRO 640", productionYear: 2019, maxCargoSpace:3000, body: nil)
manTruck.perform(action: .attachTruckBody(.tank))
manTruck.perform(action: .loadCargo(1500))
manTruck.perform(action: .switchEngine(.on))
print(manTruck)

var ferrari = SportCar(brand: "КАМАЗ", productionYear: 2017, zeroToHundredAcceleration: 3.4, topSpeed: 325)
ferrari.perform(action: .switchWindows(.closed))
ferrari.perform(action: .replaceTyres)
ferrari.perform(action: .switchEngine(.on))
print(ferrari)


