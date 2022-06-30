const bool isProduction = bool.fromEnvironment('dart.vm.product');

const devConfig = {
  // 아이폰 시뮬레이터일 경우
  'baseUrl': 'https://turtlz.co.kr/',
  // 'baseUrl': 'http://localhost:8000/',
  // 안드로이드 에뮬레이터일 경우
  // 'baseUrl': 'http://10.0.2.2:8000/',
  // 'kakaoUrl': 'http://127.0.0.1:1234/',
};
const productionConfig = {
  'baseUrl': 'https://turtlz.co.kr/',
  // 'baseUrl': 'http://localhost:8000/',
  // 'baseUrl': 'http://10.0.2.2:8000/',
  // 'kakaoUrl': 'http://localhost:1234/',
};
const environment = isProduction ? productionConfig : devConfig;

// 로그 엔트리: "그 외 장소 (예: 계단, 옥상 등)"이/가 추가되었습니다.
// 로그 엔트리: "택배함"이/가 추가되었습니다.
// 로그 엔트리: "경비실"이/가 추가되었습니다.
// 로그 엔트리: "직접 받고 부재 시 경비실"이/가 추가되었습니다.
// 로그 엔트리: "문 앞"이/가 추가되었습니다.
