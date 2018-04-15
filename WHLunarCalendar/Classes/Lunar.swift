//
//  Lunar.swift
//  Pods
//
//  Created by 김우현 on 2017. 8. 31..
//
//

import Foundation

class Lunar {
    // 1881-2050
    var monthTable: [Int] = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    let lunarTable: [String] = [
        "1212122322121", "1212121221220", "1121121222120", "2112132122122", "2112112121220",
        "2121211212120", "2212321121212", "2122121121210", "2122121212120", "1232122121212", // 1890
        "1212121221220", "1121123221222", "1121121212220", "1212112121220", "2121231212121",
        "2221211212120", "1221212121210", "2123221212121", "2121212212120", "1211212232212", // 1900
        "1211212122210", "2121121212220", "1212132112212", "2212112112210", "2212211212120",
        "1221412121212", "1212122121210", "2112212122120", "1231212122212", "1211212122210", // 1910
        "2121123122122", "2121121122120", "2212112112120", "2212231212112", "2122121212120",
        "1212122121210", "2132122122121", "2112121222120", "1211212322122", "1211211221220", // 1920
        "2121121121220", "2122132112122", "1221212121120", "2121221212110", "2122321221212",
        "1121212212210", "2112121221220", "1231211221222", "1211211212220", "1221123121221", // 1930
        "2221121121210", "2221212112120", "1221241212112", "1212212212120", "1121212212210",
        "2114121212221", "2112112122210", "2211211412212", "2211211212120", "2212121121210", // 1940
        "2212214112121", "2122122121120", "1212122122120", "1121412122122", "1121121222120",
        "2112112122120", "2231211212122", "2121211212120", "2212121321212", "2122121121210", // 1950
        "2122121212120", "1212142121212", "1211221221220", "1121121221220", "2114112121222",
        "1212112121220", "2121211232122", "1221211212120", "1221212121210", "2121223212121", // 1960
        "2121212212120", "1211212212210", "2121321212221", "2121121212220", "1212112112210",
        "2223211211221", "2212211212120", "1221212321212", "1212122121210", "2112212122120", // 1970
        "1211232122212", "1211212122210", "2121121122210", "2212312112212", "2212112112120",
        "2212121232112", "2122121212110", "2212122121210", "2112124122121", "2112121221220", // 1980
        "1211211221220", "2121321122122", "2121121121220", "2122112112322", "1221212112120",
        "1221221212110", "2122123221212", "1121212212210", "2112121221220", "1211231212222", // 1990
        "1211211212220", "1221121121220", "1223212112121", "2221212112120", "1221221232112",
        "1212212122120", "1121212212210", "2112132212221", "2112112122210", "2211211212210", // 2000
        "2221321121212", "2212121121210", "2212212112120", "1232212122112", "1212122122120",
        "1121212322122", "1121121222120", "2112112122120", "2211231212122", "2121211212120", // 2010
        "2122121121210", "2124212112121", "2122121212120", "1212121223212", "1211212221220",
        "1121121221220", "1212132121222", "1212112121220", "2121211212120", "2122321121212", // 2020
        "1221212121210", "2121221212120", "1232121221212", "1211212212210", "2121123212221",
        "2121121212220", "1212112112220", "1221231211221", "2212211211220", "1212212121210", // 2030
        "2123212212121", "2112122122120", "1211212322212", "1211212122210", "2121121122120",
        "2212114112122", "2212112112120", "2212121211210", "2212232121211", "2122122121210", // 2040
        "2112122122120", "1231212122212", "1211211221220", "2121121321222", "2121121121220",
        "2122112112120", "2122141211212", "1221221212110", "2121221221210", "2114121221221"  // 2050
    ]
    var temp: Int = 1
    var lunarDate:[String : Any] = [ "year": 1, "month": 0, "day": 1, "isYunMonth": false ]
    
    func solar2lunar(solar_date: Date) -> [String : Any] {
        var nDays = totalDays(solar_date: solar_date) - 686685
        var tmp = 0
        
        lunarDate["year"] = 1881
        lunarDate["month"] = 0
        lunarDate["day"] = 1
        lunarDate["isYunMonth"] = false
        
        repeat {
            tmp = nDays
            nDays -= nDaysYear(year: lunarDate["year"] as! Int)
            if (nDays < 0) {
                nDays = tmp
                break
            }
            lunarDate["year"] = lunarDate["year"] as! Int + 1
        } while (true)
        
        repeat {
            tmp = nDays
            nDays = nDays - nDaysMonth(lunar_date: lunarDate)
            if (nDays < 0) {
                nDays = tmp
                break
            }
            
            if ((lunarDate["month"] as! Int) == YunMonth(year: lunarDate["year"] as! Int) && !(lunarDate["isYunMonth"] as! Bool)) {
                lunarDate["isYunMonth"] = true
            } else {
                lunarDate["month"] = lunarDate["month"] as! Int + 1
                lunarDate["isYunMonth"] = false
            }
        } while (true)
        lunarDate["day"] = nDays + 1
        lunarDate["month"] = lunarDate["month"] as! Int + 1
        
        return lunarDate
    }
    
    func totalDays(solar_date: Date) -> Int {
        let thisYear = Calendar.current.component(.year, from: solar_date as Date)
        let thisMonth = Calendar.current.component(.month, from: solar_date as Date) - 1
        let thisDay = Calendar.current.component(.day, from: solar_date as Date)
        
        if ((thisYear % 4 == 0) && (thisYear % 100 != 0) || (thisYear % 400 == 0)) { monthTable[1] = 29 }
        else { monthTable[1] = 28 }
        
        var sum = 0
        for i in 0..<thisMonth {
            sum = sum + monthTable[i]
        }
        let nYears366 = Int((thisYear - 1) / 4) - Int((thisYear - 1) / 100) + Int((thisYear - 1) / 400)
        let tDays = (thisYear - 1) * 365 + sum + nYears366 + thisDay - 1
        
        return tDays
    }
    
    func nDaysYear(year: Int) -> Int {
        var sum = 0
        for i in 0..<13 {
            let char = String(lunarTable[year-1881][i])
            if( Int(char)! > 0 ) {
                sum = sum + (29 + (Int(char)! + 1) % 2)
            }
        }
        
        return sum
    }
    
    func nDaysMonth(lunar_date: [String: Any]) -> Int {
        var yun = 0
        var nDays = 0
        if( !((lunarDate["month"] as! Int) <= YunMonth(year: lunarDate["year"] as! Int) && !(lunarDate["isYunMonth"] as! Bool)) ) { yun = 1 }
        let year = lunarDate["year"] as! Int
        let char = String(lunarTable[year - 1881][(lunarDate["month"] as! Int) + yun])
        nDays = 29 + ((Int(char)! + 1) % 2)
        
        return nDays
    }
    
    func YunMonth(year: Int) -> Int {
        var yun = 0
        repeat {
            let char = String(lunarTable[year - 1881][yun])
            if( Int(char)! > 2 ) { break }
            yun = yun + 1
        } while (yun <= 12)
        
        return (yun-1)
    }
}
