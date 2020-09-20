# Animation

- 2가지 방법 존재
  - UIKit를 이용한 UIView의 API
  - Core Animation을 이용한 API
- simple Animation 이 아니라면 Core Animation 사용을 추천 [(Core Animation은 따로 작성)](https://github.com/everydayiOS/Bookcase-Of-Interstella/blob/master/Study/CoreAnimation.md)
  - 러닝 커브 높음
  - iOS의 Animation framework, Cached Bitmap과 Hardware를 내부에서 사용하여 성능이 좋음
  - Animation 자체는 다른 thread에서 작동


## UIView API 이용하기

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
  
  - **animate(withDuration: animations: completion:)**   
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
  
  ### Spring 애니메이션   
  
  - UIView.animate에는 여러 가지 애니메이션 옵션을 줄 수 잇음
  
  - **animate(withDuration: delay: usingSpringWithDamping: initialSpringVelocity: options: completion:)**   
    usingSpringWithDamping, initialSpringVelocity(스프링 속도), 여러가지 애니메이션을 제공하는 options을 파라미터로 받는 애니메이션
    
    ```
    class func animate(
      withDuration duration: TimeInterval,
      delay: TimeInterval,
      usingSpringWithDamping dampingRatio: CGFloat,
      initialSpringVelocity velocity: CGFloat,
      options: UIView.AnimationOptions = [],
      animations: @escaping () -> Void,
      completion: ((Bool) -> Void)? = nil
     )
    ```
    **usingSpringWithDamping**은 스프링 애니메이션이 정지 상태 *(=애니메이션이 끝나갈때)* 근접할 때의 damping 비율을 말함   
    0.0 ~ 1.0까지의 값을 가지고 있음   
    0에 가까울수록 심하게 damping 됨   
    
    **initialSpringVelocity**은 스프링의 속도   
    0.0 ~ 1.0까지의 값을 가지고 있음   
    0에 가까울수록 스프링의 속도가 빠름   
    
    
  ### 애니메이션 옵션   
      옵션들은 배열을 통해서 동시에 사용 가능   
  
  - **static var allowUserINteraction: UIView.AnimationOptions**   
    애니메이션 중에는 터치 이벤트가 disable되는데, 터치 이벤트를 활성화하고 싶을때 사용   
    
  - **static var repeat: UIView.AnimationOptions**   
    무한정으로 애니메이션을 반복하고 싶을때 사용   
    
  - **static var autoreverse: UIView.AnimationOptions**   
    애니메이션을 반대로도 실행할 수 있게 해주는 옵션 (repeat와 함께 사용)   
    
  - **static var curveEaseInOut: UIView.AnimationOptions**   
    기본값
    천천히 진행됐다가 duration의 중간쯤에 빨라지고, 완료되기 전에 다시 천천히 진행됨   
    
  - **static var curveEaseIn: UIView.AnimationOptions**   
    천천히 진행됐다가 진행되면서 조금씩 속도가 빨라짐   
    
  - **static var curveEaseOut: UIView.AnimationOptions**   
    빠르게 진행됐다가 완료됐을때 천천히 진행   
    
    
## Keyframe Animation
      애니메이션의 연속적인 처리에 유용한 keyframe   
      
   - UIView.animate로는 간단한 애니메이션은 가능
   - 순차적으로 애니메이션들이 진행된다면 completion 클로저를 이용해서 애니메이션을 구현 *~~(콜백 지옥...)~~*
   
   - **animateKeyframes**   
   
   ```
   class func animateKeyframes (
      withDuration duration: TimeInterval,
      delay: TimeInterval,
      options: UIView.KeyframeAnimationOptions = [],
      animations: @escaping() -> Void,
      completion: ((Bool) -> Void)? = nil
      )
   ```
    
   - **addKeyframe**  
   
   ```
   class func addKeyframe (
    withRelativeStartTime frameStaratTiem: Double,
    relativeDuration frameDuration: Double,
    animations: @escaping () -> Void
    )
   ```
   UIView.animateKeyframes 안에 addKeyframe을 추가하는 방식으로 시간의 순서대로 애니메이션 동작 가능   
   
   ```
   UIView.animateKeyframes(withDuration: 4.0, delay: 0, options: [],
    animations: {
      UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.25) {self.animate1()}
      UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.25) {self.animate2()}
      UIView.addKeyframe(withRelativeStartTime: 0.50, relativeDuration: 0.25) {self.animate3()}
      UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25) {self.animate4()}
     }, completion: nil)
   ```
   0.25초씩 각각의 애니메이션이 진행됨
