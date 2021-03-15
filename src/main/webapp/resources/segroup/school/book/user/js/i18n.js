var i18n = require('i18n'); //i18n 모듈 불러오기

/** 옵션 설정 */
i18n.configure({
  locales:['ko', 'en'], //사용언어 설정 / 'de' 나 'ja' , 'fr' 등등 추가 가능
  directory: __dirname + '/locales', // 사용언어에 대한 템플릿폴더 생성위치, 
//  directory: '/resources/locales/__lng__.json',
  defaultLocale: 'ko', //기본 사용언어 설정
  cookie: 'lang', //쿠키의 이름 설정, 개발자가 자유롭게 이름 설정가능
});

module.exports = function(req, res, next) {
  i18n.init(req, res);
  res.locals.__ = res.__;
  var current_locale = i18n.getLocale();
  return next();
};