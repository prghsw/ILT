## 쿠버네티스 파드 접속하기. (https://blog.frankel.ch/basics-access-kubernetes-pods/)

1. setup
  - kind (https://kind.sigs.k8s.io/)를 사용하여 로컬 개발 및 CI 처리.
  - kind란 도커 컨테이너 노드를 사용 한 로컬 쿠버네티스 클러스터 실행 도구이다.
  - kind 설치

 `brew install kind`
 
### create two nodes cluster

- kind.yml
 ```
kind: Cluster
apiVersion: kind.x-k8s.io/vlalpha4
nodes:
- role: control-plane
  extraPortMappings:
  - containerPort: 30800 > port forwarding
    hostPort: 30800      > port forwarding
- role: worker  > nodes
- role: worker  > nodes
 ```
 
 `kind create cluster --config kind.yml`
 
 <pre>
 -------- cluster ---------
 |  worker1      worker2  |
 |     ㅁ          ㅁ      |
 -------------------------- 
 </pre>
 
 ### Need container > run nginx container
 - nginx image pull
```
docker pull nginx:1.23
kind load docker-image nginx:1.23
```
- alias set
`alias k=kubectl`

### create pod / no outside access by default

`k create deployment nginx --image=nginx:1.23`

`k get pod`

`k get pod nginx-6c7985744b-mwsdb --template '{{.status.podIP}}'`

```
k exec -it nginx-6c7985744b-c7cpl -- /bin/bash
hostname -I
```

<pre>
 -------- cluster ---------
 |  worker1     worker2   |
 |  -------        ㅁ      |
 |  |nginx |              |
 |  |  ㅁ  |               |
 |  -------               |
 --------------------------
 </pre>
 
 ```
kubectl delete pod nginx-6c7985744b-mwsdb
> self-healing pods
kubectl get pods
kubectl exec -it nginx-6c7985744b-hs24k -- hostname -I
 ```
 
 - pods를 생성 할 때 마다 IP 가 변경 되기 때문에, 직접적인 파드의 IP를 사용 하는 것은 불가 하다.
 - 이 부분을 해결 하기 위해 쿠버네티스에서는 Service 객체를 제공한다.
 - Service는 파드의 앞에서 상태 인터페이스를 표현한다.
 - 쿠버네티스는 파드들과 서비스 간에 맵핑을 관리한다.
### expose deployment with service
`kubectl expose deployment nginx --type=ClusterIP --port=8080`
`kubectl get svc`

> ClusterIP: Exposes the Service on a cluster-internal IP. 
> Choosing this value makes the Service only reachable from within the cluster.
> This is the default ServiceType.

<pre>
 -------- cluster ---------
 |  worker1     worker2   |
 |  -------        ㅁ      |
 |  |nginx |              |
 |  |  ㅁ <<--- nginx clusterIp (service) |
 |  -------               |
 --------------------------
 </pre>

  - clusterIp를 이용하여 외부에 노출 되지 않고 내부에서 접근 가능 하도록 설정 할 수 있습니다.

### Accessing Pods
  - NodePort를 사용하여 간단하게 외부에서 접근 가능 하도록 할 수 있습니다.
  - ClusterIp에 NodePort 접근을 추가 하면 됩니다.

> NodePort: Exposes the Service on each Node’s IP at a static port (the NodePort).
A ClusterIP Service, to which the NodePort Service routes, is automatically created. 
You’ll be able to contact the NodePort Service, from outside the cluster, by requesting <NodeIP>:<NodePort>.
  
  - deployment.yml
  ```
  apiVersion: apps/v1
kind: Deployment
metadata:
  name: nginx
  labels:
    app: nginx
spec:
  replicas: 1
  selector:
    matchLabels:
      app: nginx
  template:
    metadata:
      labels:
        app: nginx
    spec:
      containers:
      - name: nginx
        image: nginx:1.23
        volumeMounts:
          - name: conf
            mountPath: /etc/nginx/nginx.conf
            subPath: nginx.conf
            readOnly: true
      volumes:
        - name: conf
          configMap:
            name: nginx-conf
            items:
              - key: nginx.conf
                path: nginx.conf
---
apiVersion: v1
kind: ConfigMap
metadata:
  name: nginx-conf
data:
  nginx.conf: |
    events {
       worker_connections 1024;
    }
    http {
        server {
            location / {
                default_type text/plain;
                return 200 "host: $hostname\nIP:    $server_addr\n";
            }
        }
    }
---
apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  selector:
    app: nginx
  type: NodePort
  ports:
    - port: 80
      nodePort: 30800
  ```
  
  `kubectl apply -f deployment.yml`
  `curl localhost:30800`
  
 <pre>
 -> localhost 30800 call > request goes any node(worker)
 
 > curl localhost:30800
 >> worker1 or worker2 (node's Port 30800) / target NodePort Service 80:30800 /
 >>> forward request to NodePort service (80:30800)
 >>>> Service forard request target pod port , translating port from 30800 to 80
 </pre>
  
  - two pods call process
  `kubectl scale deployment nginx --replicas=2`
  `kubectl get pods -o wide`
  `while true; do curl localhost:30800; done`
  
  ### loadbalancing
  >LoadBalancer: Exposes the Service externally using a cloud provider’s load balancer.
  NodePort and ClusterIP Services, to which the external load balancer routes, are automatically created.
 
  >MetalLB is a load-balancer implementation for bare metal Kubernetes clusters, using standard routing protocols.
  
  ```
  apiVersion: v1
kind: Service
metadata:
  name: nginx
spec:
  selector:
    app: nginx
  type: LoadBalancer
  ports:
    - port: 80
      targetPort: 30800
  ```
