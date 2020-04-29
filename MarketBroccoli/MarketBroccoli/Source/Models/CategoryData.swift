//
//  CategoryData.swift
//  MarketBroccoli
//
//  Created by Hailey Lee on 2020/03/27.
//  Copyright © 2020 Team3. All rights reserved.
//

import Foundation


// MARK: - CategoryModel
struct CategoryModel2: Codable {
    let id: Int
    let name: String
    let imageBk, imagePp: String
    let subcategories: [Subcategory]
    enum CodingKeys: String, CodingKey {
        case id, name
        case imageBk = "image_bk"
        case imagePp = "image_pp"
        case subcategories
    }
}
// MARK: - Subcategory
struct Subcategory: Codable {
    let id: Int
    let name: String
}






struct CategoryModel {
  var select: Bool
  let title: String
  let imagePurple: String
  let imageBlack: String
  let row: [String]
  let ids: [Int]
}

var categoryData: [CategoryModel] =
  [
    CategoryModel(
      select: false,
      title: "채소",
      imagePurple: "채소_보라",
      imageBlack: "채소_검정",
      row: ["전체보기", "기본채소", "쌈·샐러드·간편채소", "브로콜리·특수채소", "콩나물·버섯류", "양파·마늘·생강·파", "시금치·부추·나물", "파프리카·피망·고추"], ids: [1, 2, 3, 4, 5, 6, 7]
    ),
    CategoryModel(
      select: false,
      title: "과일·견과·쌀",
      imagePurple: "과일_보라",
      imageBlack: "과일_검정",
      row: ["전체보기", "국산과일", "수입과일", "냉동·건과일", "견과류", "쌀·잡곡"],
      ids: [8, 9, 10, 11, 12]
    ),
    CategoryModel(
      select: false,
      title: "수산·해산·건어물",
      imagePurple: "수산_보라",
      imageBlack: "수산_검정",
      row: ["전체보기", "생선류", "오징어·낙지·문어", "새우·게·랍스터", "해산물·조개류", "수산가공품", "김·미역·해조류", "건어물·다시팩"],
      ids: [13, 14, 15, 16, 17, 18, 19]
    ),
    CategoryModel(
      select: false,
      title: "정육·계란",
      imagePurple: "정육_보라",
      imageBlack: "정육_검정",
      row: ["전체보기", "소고기", "돼지고기", "계란류", "닭·오리고기", "양념육·돈까스", "양고기"],
      ids: [20, 21, 22, 23, 24, 25]
    ),
    CategoryModel(
      select: false,
      title: "국·반찬·메인요리",
      imagePurple: "국_보라",
      imageBlack: "국_검정",
      row: ["전체보기", "국·탕·찌개", "밑반찬", "김치·장아찌·젓갈", "두부·어묵·부침개", "햄·소시지·통조림", "메인요리"],
      ids: [26, 27, 28, 29, 30, 31]
    ),
    CategoryModel(
      select: false,
      title: "샐러드·간편식",
      imagePurple: "샐러드_보라",
      imageBlack: "샐러드_검정",
      row: ["전체보기", "샐러드·도시락", "간편식·냉동식품", "밥류·면식품·즉석식품", "선식·시리얼·그래놀라", "만두·튀김·떡볶이", "죽·스프"],
      ids: Array(32...37)
    ),
    CategoryModel(
      select: false,
      title: "면·양념·오일",
      imagePurple: "면_보라",
      imageBlack: "면_검정",
      row: ["전체보기", "파스타·면류", "밀가루·가루·믹스", "향신료·소스·드레싱", "양념·액젓·장류", "소금·설탕·식초·꿀", "식용유·참기름·오일"],
      ids: Array(38...43)
    ),
    CategoryModel(
      select: false,
      title: "음료·우유·떡·간식",
      imagePurple: "음료_보라",
      imageBlack: "음료_검정",
      row: ["전체보기", "생수·음료·주스", "커피·차", "우유·두유·요거트", "아이스크림", "떡·한과", "간식·과자·쿠키", "초콜릿·젤리·캔디"],
      ids: Array(44...50)
    ),
    CategoryModel(
      select: false,
      title: "베이커리·치즈·델리",
      imagePurple: "베이커리_보라",
      imageBlack: "베이커리_검정",
      row: ["전체보기", "식빵·빵류", "잼·버터·스프레드", "케이크·파이·디저트", "치즈", "건조육", "올리브·피클·델리"],
      ids: Array(51...56)
    ),
    CategoryModel(
      select: false,
      title: "건강식품",
      imagePurple: "건강식품_보라",
      imageBlack: "건강식품_검정",
      row: ["전체보기", "건강즙·건강음료", "홍삼·인삼·꿀", "영양제", "유산균", "건강분말·건강환", "유아동"],
      ids: Array(57...62)
    ),
    CategoryModel(
      select: false,
      title: "생활용품",
      imagePurple: "생활용품_보라",
      imageBlack: "생활용품_검정",
      row: ["전체보기", "휴지·티슈·위생용품", "세제·청소용품", "인테리어소품", "의약외품·마스크", "생활잡화·문구", "헤어·바디케어", "스킨케어", "구강케어·면도용품"],
      ids: Array(63...70)
    ),
    CategoryModel(
      select: false,
      title: "주방용품",
      imagePurple: "주방용품_보라",
      imageBlack: "주방용품_검정",
      row: ["전체보기", "주방소모품", "주방·조리기구", "냄비·팬류", "식기류", "컵·와인잔·사케잔", "차·커피도구"],
      ids: Array(71...76)
    ),
    CategoryModel(
      select: false,
      title: "가전제품",
      imagePurple: "가전제품_보라",
      imageBlack: "가전제품_검정",
      row: ["전체보기", "주방가전", "생활가전"],
      ids: Array(77...78)
    ),
    CategoryModel(
      select: false,
      title: "베이비·키즈",
      imagePurple: "베이비_보라",
      imageBlack: "베이비_검정",
      row: ["전체보기", "분유·간편 이유식", "이유식 재료", "유아·어린이 음식", "간식·음료·건강식품", "유아용품·젖병·식기류", "기저귀·물티슈", "목욕·세제·위생용품"],
      ids: Array(79...85)
    ),
    CategoryModel(
      select: false,
      title: "반려동물",
      imagePurple: "반려동물_보라",
      imageBlack: "반려동물_검정",
      row: ["전체보기", "강아지 간식", "강아지 주식", "고양이 간식", "고양이 주식", "반려동물 용품"],
      ids: Array(86...90)
    )
]
