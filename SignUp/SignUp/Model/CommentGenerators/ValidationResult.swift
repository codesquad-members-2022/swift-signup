//
//  CommentGenerator.swift
//  SignUp
//
//  Created by 백상휘 on 2022/03/28.
//

import Foundation

//protocol CommentGenerator {
//    func convertComment(in string: String, with result: ValidationResult)
//}

// color, state, result는 이벤트가 입력될 때마다 수시로 바뀌어야 하므로 이 프로토콜을 구현하는 클래스를 생성하기로 하였습니다.
protocol ValidationResult {
    // 코멘트를 표시하는 UILabel의 색을 열거형으로 표현합니다.
    var commentColor: CommentColor { get }
    // 맞는지 틀리는지 여부를 열거형으로 표현합니다.
    var state: ValidationResultState { get set }
    // 정규식으로 얻어내는 상세 결과를 이용해 다양한 코멘트를 남길 수 있어야 합니다.
    var validateResult: [NSTextCheckingResult] { get set }
    func validateResultState(in string: String, using results: [NSTextCheckingResult])
    /// 여러 조건에 따라 Comment를 생성하기 위한 메소드입니다.
    ///
    /// in = 검증하려는 텍스트 원문입니다.
    func commentRepresentation(in string: String) -> String
}

enum CommentColor {
    case red
    case green
    case yellow
}

enum ValidationResultState {
    case good
    case bad
}
