//
//  Constants.swift
//  TMDB-RxSwift
//
//  Created by albooren on 19.12.2023.
//

import UIKit

let screenHeight: CGFloat = UIScreen.main.bounds.height
let screenWidth: CGFloat = UIScreen.main.bounds.width

let apikey = "Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlOTRhMTJjOGEzMWE1NzgwM2NiMjdmMTA0ZjliOWQyZCIsInN1YiI6IjYyYWNkMWZjYzdhN2UwMDA1MWQ1MzZiMiIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.i4qsTEOMR0jr_8G8up3ahxNSwW7KE-h4jtvtzpAWf5g"

let serverDateFormat = "yyyy-mm-dd"
let clientDateStringFormat = "dd MMMM Y"

let currentLanguageCode : String = {
    let code = Locale.current.languageCode
    return code ?? "en"
}()
