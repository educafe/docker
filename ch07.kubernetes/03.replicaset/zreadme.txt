ReplicaSet 관리대상은
--------------------
 selector:
    matchLabels:
      role: webserver
에 정의한 matchLabels와 일치하는 metadata Label 정보를 가지는 pod 들이다.
따라서 metadata Label의 정보가 다른 pod는 대상에 포함되지 않는다.

이를 시험하기 위해서
02-1.nginx-pod.yml을 먼저 실행한 후 01.nginx-replicaset.yml을 실행한 경우
02-1.nginx-pod.yml에 의해서 생성된 pod는 relicaset 대상이 되지 않는다
