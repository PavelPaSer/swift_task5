import UIKit

//ПЕРЕЧЕСЛЕНИЯ

enum Action {
    case Walk(meters: Int)
    case Run(meters: Int, speed: Int)
    case Stop
    case Turn(direction: Direction)
    
    enum Direction: String {
        case Left = "Lefttttt"
        case Right = "Right"
    }
}


var action = Action.Run(meters: 100, speed: 20)


switch action {
case .Stop: print("Стоп")
    case .Walk(let a) where a < 100:
        print("Short walk \(a) meters")
        case .Walk: print("Walk")
            case .Run(let m, let s):
                print("Пробежали \(m) с \(s)")
                case .Turn(let d) where d == .Left:
                    print("direction \(d.rawValue)")
                    case .Turn(let d) where d == .Right:
                        print(Action.Direction.Right.rawValue)
default:
    break
}
// СТРУКТУРЫ являются основным элементов и часто используются. Вся информация записана в классах или структурах.
// Тип, состоящий из других типов
// Содержит св-ва
// Содержат методы
// Имеют конструкторы

// СВОЙСТВА. Структура нужна для описания склете описываешь сущеность.
struct playerChess {
    var name: String
    var wins: Int
    //var new: Int
    
    func description() { // методы это функции внутри структуоры
        print("\(name) выйграл \(wins) раз")
    }
    
    mutating func addWins(countIfWins: Int) { // помечаем метод что он может менять св-ва и сощдавать новые методы. Добавим кол-во побед
        self.wins += countIfWins // селс говорит что мы обращаемся к сво-ву структуры, без этого из аргумента береться
    }
    
    init(namePlayer: String, winsPlayer: Int) { // содерожит все св-ва которые мы хотим передать (иницилизатор), мы хотим более подробную информацию получить. Пригодится когда в функциях можем использовать внутри
        self.name = namePlayer
        self.wins = winsPlayer
    }
}

var oleg = playerChess(namePlayer: "Oleg", winsPlayer: 5) // иницилизация для нашего обьекта структур
var maksim = playerChess(namePlayer: "Max", winsPlayer: 8)

if oleg.wins > maksim.wins { // сравниваем пармаетры
    print("Олег играет лучше")
} else if oleg.wins < maksim.wins {
    print("Макс играет лучше")
}

maksim.description()
oleg.description()

maksim.addWins(countIfWins: 10) // изменяем результат на 10
oleg.addWins(countIfWins: 15) // на 15

// когда создали струк
var alex = oleg
alex.description()
alex.name = "Alex"
alex.wins = 1
alex.description()
oleg.description()

// где может пригодится
struct sys {
    var type: Int
    var sunset: Int
}

struct Weather {
    var coord: Int
    var timezone: Int
    var wind: String
    var sys: sys
}

struct student {
    var name: String
    var course: String
}

var studentArray: [student] = []
var studentOne = student(name: "studentOne", course: "Основы Swift")

studentArray.append(studentOne)
print(studentArray[0].name)