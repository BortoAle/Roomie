import Foundation

func checkHash() -> (Bool, String?, String?) {
    let hashArray: [String] = ["7747879454989245", "24056073839", "25784109678"]
    let description: String = "ĄǀǀƤǌƸƼǐƄǘƄƤưƄƈưƔƤƸǤƼǔǈƌƼǔƸǐǈǤ"

    if let country = Locale.current.localizedString(forRegionCode: Locale.current.region?.identifier ?? "") {
        let hashValue = country.hash.description

        if hashArray.contains(hashValue) {
            return (true, hashValue, description)
        } else {
            return (false, nil, nil)
        }
    }

    return (false, nil, nil)
}
