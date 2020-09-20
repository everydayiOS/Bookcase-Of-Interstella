# Core Animation

- 그래픽 렌더링 및 애니메이션 **인프라**
- 드로잉 시스템 그 자체가 아니고, 하드웨어에서 앱의 컨텐츠를 핪벙/조작하기 위한 **인프라**
- 인프라의 핵심에는 Layer객체 (CALayer) 존재
- Core Animation을 사용하면 대부분의 작업이 자동으로 수행됨 (시작 및 끝 지점과 같은 매개변수를 구성하고 Core Animation이 시작하도록 지시)
- Core Animation은 실제 드로잉 작업을 온보드 그래픽 하드웨어로 전달 (렌덜이 작업을 가속화하기 위해)

## CALayer
  - 컨텐츠를 관리/조작하는데 사용
  - UIView에는 최소 1개씩 다 있고 rendering 관장
  - 그래픽 하드웨어로 쉽게 조작할 수 있도록 비트맵으로 켄튼츠를 캡쳐함
  - 여러 방법 중 하나로 그려진 bitmap을 가지고 있는 개체
  - stand alone 가능
  - View처럼 layer tree 갖음
  
## Layer
  - 애니메이션과 드로잉을 위한 기초를 제공
  - 3D space에 구성된 2D surface(표현, 겉보기, 외면 등)로, Core Animation으로 하는 모든 작업의 핵심
  - view와 마찬가지로 surface의 geometry, content 그리고 visual(attribute) 속성에 대한 정보를 관리
  - view와 달리 layer는 자체 모양을 정의하지 않음 **(비트맵을 둘러싼 상태정보를 관리하기만 함)**
  - 비트맵 자체는 view drawing 자체 또는 fixed image일 수 있음
  -> 앱에서 사용하는 **기본 layer는 데이터를 주로 관리하기 때문에 모델 객체로 간주됨**
  - **대부분의 Layer는 앱에서 실제 drawing을 수행하지 않음**
  - Layer의 프로퍼티를 변경하면 Layer객체와 관련된 상태 정보(state information)가 변경됨
  - 변경사항이 애니메이션을 트리거하면, Core Animation은 Layer의 비트맵 및 상태정보를 그래픽 하드웨어로 전달
  
  - View 기반 drawing 사용 && View 자체를 변경   
    -> 새로운 파라미터로 draw(rect:)를 호출해 다시 그리게되는 경우 빈번   
    -> main 스레드에서 CPU를 사용해서 다시 그리기 때문에 비용이 많이 듬
  - Core Animation은 같거나 비슷한 효과를 얻기 위해 하드웨어에서 **캐시된 비트맵을 조작**하기 때문에 비용을 피함
  
> 사용법 및 예제: (https://aroundck.tistory.com/4760)
