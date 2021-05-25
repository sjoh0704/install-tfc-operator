# tfc-operator 설치 가이드

## 구성 요소 및 버전
* tfc-operator
	* image: [tmaxcloudck/tfc-operator:b5.0.1.0](https://hub.docker.com/layers/tmaxcloudck/tfc-operator/b5.0.1.0/images/sha256-4e65c5f02a4c9833d6e196a53996ae918bc05a180794e716b9b869a1228cd868?context=explore)
	* git: [https://github.com/tmax-cloud/tfc-operator](https://github.com/tmax-cloud/tfc-operator)

* tfc-worker: [tmaxcloudck/tfc-worker:v0.0.1](https://hub.docker.com/layers/tmaxcloudck/tfc-worker/v0.0.1/images/sha256-c7bbe01e2280c497cb8c927b9c6de4db424c2837c275c1eba99e65fb2d8e84cf?context=repo)

## Prerequisite
* 필수 모듈  
  * kubectl version v1.11.3+.
  * Access to a Kubernetes v1.11.3+ cluster.

## 폐쇄망 구축 가이드
설치를 진행하기 전 아래의 과정을 통해 필요한 이미지 및 yaml 파일을 준비한다.

1. **폐쇄망에서 설치하는 경우** 사용하는 image repository에 Operator Lifecycle Manager 설치 시 필요한 이미지를 push한다. 

    * 작업 디렉토리 생성 및 환경 설정
    ```bash
    $ mkdir -p ~/tfc-install
    $ export TFC_HOME=~/tfc-install
    $ export TFC_VERSION=b5.0.0.0
    $ export REGISTRY= XXX.XXX.XXX.XXX:XXXX (e.g.192.168.6.100:5000)
    $ cd $TFC_HOME
    ```
    * 외부 네트워크 통신이 가능한 환경에서 필요한 이미지를 다운받는다.
    ```bash
    $ sudo docker pull tmaxcloudck/tfc-operator:${TFC_VERSION}
    $ sudo docker save tmaxcloudck/tfc-operator:${TFC_VERSION} > tfc_operator_${TFC_VERSION}.tar
    $ sudo docker pull tmaxcloudck/tfc-worker:v0.0.1
    $ sudo docker save tmaxcloudck/tfc-worker:v0.0.1 > tfc_worker_v0.0.1.tar
    ```
    
    * install yaml을 다운로드한다.
    ```bash
    $ git clone https://github.com/tmax-cloud/install-tfc-operator.git
    $ cd install-tfc-operator/manifest
    ```
  
2. 위의 과정에서 생성한 tar 파일들을 폐쇄망 환경으로 이동시킨 뒤 사용하려는 registry에 이미지를 push한다.
    ```bash
    $ sudo docker load < tfc_operator_${TFC_VERSION}.tar
    
    $ sudo docker tag tmaxcloudck/tfc-operator:${TFC_VERSION} ${REGISTRY}/tfc-operator:${TFC_VERSION}
    
    $ sudo docker push ${REGISTRY}/tfc-operator:${TFC_VERSION}
    
    $ sudo docker load < tfc_worker_v0.0.1.tar
    
    $ sudo docker tag tmaxcloudck/tfc-worker:v0.0.1 ${REGISTRY}/tfc-worker:v0.0.1
    
    $ sudo docker push ${REGISTRY}/tfc-worker:v0.0.1
    ```
    

## 설치 가이드
0. [yaml 수정](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-0-yaml-%EC%88%98%EC%A0%95)
1. [Namespace 생성](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-1-namespace-%EC%83%9D%EC%84%B1)
2. [CRD 생성](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-2-crd-%EC%83%9D%EC%84%B1)
3. [RBAC 생성](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-3-rbac-%EC%83%9D%EC%84%B1)
4. [Deployment 생성](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-4-deployment-%EC%83%9D%EC%84%B1)

## Step 0. yaml 수정

## Step 1. Namespace 생성
* 목적 : `tfc-operator 설치를 위해 필요한 Namespace를 생성한다.`
* 생성 순서 : [01_namespace.yaml](manifest/01_namespace.yaml) 실행

## Step 2. CRD 생성
* 목적 : `tfc-operator에서 감시할 CRD (tfapplyclaim)를 생성한다.`
* 생성 순서
  * [02_crd.yaml](manifest/02_crd.yaml) 실행
  
## Step 3. RBAC 생성
* 목적 : `tfc-operator가 동작하기 위해 필요한 권한 설정 (clusterrole, clusterrolebinding)을 생성한다.`
* 생성 순서
  * [03_rbac.yaml](manifest/03_rbac.yaml) 실행

## Step 4. Deployment 생성
* 목적 : `tfc-operator의 Deployment 객체를 생성한다.`
* 생성 순서
  * [04_deployment.yaml](manifest/04_deployment.yaml) 실행

## 삭제 가이드
1. [Deployment 삭제](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-1-deployment-%EC%82%AD%EC%A0%9C)
2. [RBAC 삭제](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-2-rbac-%EC%82%AD%EC%A0%9C)
3. [CRD 제거](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-3-crd-%EC%A0%9C%EA%B1%B0)
4. [Namespace 제거](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-4-namespace-%EC%A0%9C%EA%B1%B0)

## Step 1. Deployment 삭제
* 목적 : `tfc-operator의 Deployment를 삭제한다.`
* 삭제 순서 : 아래의 command 순서대로 적용
    ```bash
    $ kubectl delete -f manifest/04_deployment.yaml
    ```

## Step 2. RBAC 삭제
* 목적 : `RBAC 권한 삭제`
* 삭제 순서 : 아래의 command로 yaml 적용
    ```bash
    $ kubectl delete -f manifest/03.rbac.yaml
    ```
    
## Step 3. CRD 제거
* 목적 : `tfc-operator 관련 CRD 제거`
* 삭제 순서 : 아래의 command로 yaml 적용
    ```bash
    $ kubectl delete -f manifest/02_crd.yaml
    ```    
## Step 4. Namespace 제거
* 목적 : `tfc-operator가 동작하는 Namespace를 삭제한다`
* 삭제 순서 : 아래의 command로 yaml 적용
    ```bash
    $ kubectl delete -f manifest/01_namespace.yaml
    ```     
