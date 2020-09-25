# DispatchQueue

DispatchQueue를 사용하는 기본적인 형태이다.
```
/* 1️⃣ 큐에 보낼거야, 2️⃣ 글로벌큐에, 3️⃣ 비동기적으로 */
DispatchQueue.global().async {
	// Task : Closure로 구현
}
```

## 1️⃣ GCD
**GCD(Grand Central Dispatch)** : 동시성 작업을 관리하는 기술로 Dispatch Queue라고 칭함.

다음과 같은 특징을 갖는다.
- 호출자와 관련된 임의의 코드 블럭을 동기/비동기식으로 수행함.
- 별도의 스레드에서 수행하는 대부분의 작업을 수행할 수 있음.
- FIFO 구조로 작업을 추가한 순서대로 수행함.
- 시스템이 스레드의 개수, 메모리를 관리하여 속도와 사용성면에서 뛰어남.

## 2️⃣ GCD 종류와 특성

- Main (Serial) : Main Thread에서 Task를 순차적으로 수행한다.
- Global (Concurrent) : 여러 개의 스레드를 생성해서 동시에 여러 Task를 처리한다.
6가지 종류를 선택할 수 있으며 우선순위에 따라 수행된다.
 - userInteractive : 거의 즉시, UI 업데이트, Animation
 - userInitiated : 몇 초, 유저가 필요하지만 비동기적으로 처리된 작업
 - default : 일반적인 작업
 - utility : 몇 초 ~ 몇 분, 길게 실행되는 작업 e.g. 네트워킹, 계산
 - background : 속도보다 에너지 효율성 중시, 몇 분이상, e.g. 데이터 미리 가져오기
 - unspecified : Legacy API
- Private (Custom) : 기본적으로 Serial로 생성되지만 Concurrent로 변경할 수 있다. 레이블을 지정하여 필요한 만큼 Queue를 생성할 수 있다.

### Serial과 Concurrent
- 직렬(Serial) : Main에서 시킨 작업을 다른 한 개의 스레드에서 처리한다.
 - 순서가 중요한 작업에 적합하다.
- 동시(Concurrent) : Main에서 시킨 작업을 다른 여러 개의 스레드에서 처리한다.
 - 독립적이지만 유사한 여러 개의 작업을 처리할 때 적합하다.  e.g. 이미지를 다운받아 뿌려주는 collection view

## 3️⃣ 동기 vs 비동기
- 동기(Sync) : 다른 스레드에서 일을 시작 시키고, 작업이 끝날때까지 block 상태로 기다린다.
- 비동기(Async) : 다른 스레드에서 일을 시작 시키고, 작업이 끝날때까지 기다리지 않는다. 네트워크와 관련된 작업에 빈번히 사용된다.

## 주의사항
- UI 화면 관련 작업은 Main Queue에서 처리해야 한다.
- Task 내에서 다른 Queue에 보내는 작업이 가능하다. e.g. Global Queue Task의 마지막 UI 작업은 Main Queue로 보낼 수 있다.
- Main Queue에서는 항상 async로 보내야 한다. sync로 보내면 UI가 멈추는 문제가 발생한다.
- 동일한 Queue에 sync 하면 안된다.
```
DispatchQueue.global().async {
	DispatchQueue.global().sync { 
	} // 결과 반환 시, 호출 후 Block된 상태의 동일 스레드에 접근하여 교착상태 발생할 수 있음.
}
```
- weak, strong 캡쳐 주의 : Closure이기 때문에 strong type으로 캡쳐할 경우 객체가 소멸되어도 Task는 남아있음. weak을 사용해야 한다.
- completionHandler를 사용하여 비동기 작업이 명확히 끝나는 시점을 알 수 있다.

## Dispatch Group
그룹으로 묶인 작업이 끝나는 시점을 알고 싶을 때 사용한다.
```
let group = DispatchGroup()
DispatchQueue.global().async(group: group) { /* Task */ }
```
- group.notify로 끝나는 시점에 Task를 수행할 수 있다.
```
group.notify(queue: DispatchQueue.main) {
    print("작업 완료")
}
```
- group.wait으로 대기시간을 지정할 수 있다.
```
group.wait(timeout: DispatchTime.distantFuture)
```

그룹에 속한 Task에서 async 호출 시 enter(), leave()를 사용하여 그룹의 종료 시점을 정확히 알 수 있도록 한다.
- e.g. #1 UIView를 extenstion하여 animation을 group.enter(), group.leave()로 감싸 animation 종료 시점에 특정 작업을 하도록 활용할 수 있다.
```
extension UIView {
    static func animate(withDuration duration: TimeInterval, animations: @escaping () -> Void, group: DispatchGroup, completion: ((Bool) -> Void)?) {
        group.enter()
        animate(withDuration: duration, animations: animations) { (success) in completion?(success)
            group.leave()
        }
    }
}
```
- e.g. #2 이미지를 모두 다운받은 뒤 종료 시점에 특정 작업을 할 수 있다.

## Dispatch Work Item
Dispatch 작업을 객체화하여 재사용성할 수 있다.
```
let item = DispatchWorkItem { /* Task */ }
DispatchQueue.global().async(execute: item)
```
- cancel() : 작업이 실행 전이면 제거, 실행 중이면 isCancelled가 true로 설정됨.
```
item.cancel()
```
- notify(queue: 다음 Queue, execute: 다음 Task) : 작업 종료 후 수행할 Task를 지정할 수 있음.
```
item.notify(queue: DispatchQueue.main, execute: item2)
```

## Dispatch Semaphore
공유 리소스에 접근가능한 작업 수를 제한할 경우 사용된다.
- wait() : 자원이 있으면 쓰고, 없으면 기다림.
- signal() : 작업을 마쳤으니 자원을 회수함.

## 참고
- https://zeddios.tistory.com/513
- [iOS Concurrency(동시성) 프로그래밍, 동기 비동기 처리 그리고 GCD/Operation](https://inf.run/6Ctr)