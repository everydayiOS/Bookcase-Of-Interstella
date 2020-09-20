# Animation

- 2가지 방법 존재
  - UIKit를 이용한 UIView의 API
  - Core Animation을 이용한 API


## UIView 이용하기

- iOS 4부터 Closure형태인 animate 메서드를 주로 이용 *~~(언젠가 deprecated 될덧...)~~*
- 공식 문서에는 UIViewPropertyAnimator 사용 권장 (iOS 10이상 부터 사용 가능한 API)


  ### Animate
  
  - Closure 기반
  - 애니메이션이 동작하는 동안 user interaction은 일시적으로 disable
  - 애니메이션이 가능한 속성: frame, bounds, center, transform, alpha, backgroundColor
  
  
