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
  
  - **animate(withDuration: animations:)**
    duration, animations의 파라미터로 받는 애니메이션의 기본 메서드
  ```
  class func animtate(
    withDuration duration: TimeInterval,
    animations: @escaping () -> Void
    )
  ```
  
  - **animate(withDuration: animations: completion:)
    duration, animations의 파라미터로 받는 애니메이션
    기본 애니메이션이 완료되면 completion이 동작하는 메서드
  ```
  class func animate(
    withDuration duration: TimeInterval,
    animations: @escaping () -> Void,
    completion: ((Bool) -> Void)? = nil
    )
  ```
  
  ```
  var object = CGRect(x: 50, y: 150, width: 50, height: 50)
  
  UIView.animate(withDuration: 2.0, animations: {
  //duration동안의 애니메이션이 동작하는 구간
    object.frame = CGRect(x: 100, y: 400, width: 200, height: 200)   // 좌표(50, 100), size(50)에서 좌표(100, 400), size(200)으로 2초간 애니메이션
  }, completion: { finished in
  // 애니메이션이 끝나고 나서 동작하는 구간
  })
  ```
  
  - **해제 방법**
    layer에 접근해 animation을 remove 시켜주면 애니메이션을 해제할 수 있음
    ```
    object.layer.removeAllAnimations()
    ```
