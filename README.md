# tfc-operator 설치 가이드

## 구성 요소 및 버전
* tfc-operator
	* image: [https://hub.docker.com/layers/150143370/tmaxcloudck/tfc-operator/b5.0.0.0/images/sha256-0fea66beef0b861afef43c00c7a6ba2ecee471799df9c6df98c3db45c2a19243?context=explore)
	* git: [https://github.com/tmax-cloud/tfc-operator](https://github.com/tmax-cloud/tfc-operator)

* tfc-worker (https://hub.docker.com/layers/tmaxcloudck/tfc-worker/v0.0.1/images/sha256-c7bbe01e2280c497cb8c927b9c6de4db424c2837c275c1eba99e65fb2d8e84cf?context=repo)

## Prerequisite
* 필수 모듈  
  * kubectl version v1.11.3+.
  * Access to a Kubernetes v1.11.3+ cluster.

## 폐쇄망 구축 가이드
설치를 진행하기 전 아래의 과정을 통해 필요한 이미지 및 yaml 파일을 준비한다.


## 설치 가이드
0. [yaml 수정](https://github.com/tmax-cloud/install-OLM/blob/main/README.md#step-0-olm-yaml-%EC%88%98%EC%A0%95-%EC%88%98%EC%A0%95)
1. [CRD 생성](https://github.com/tmax-cloud/install-OLM/blob/main/README.md#step-1-crds-%EC%83%9D%EC%84%B1)
2. [RBAC 생성](https://github.com/tmax-cloud/install-OLM/blob/main/README.md#step-2-olm-%EC%84%A4%EC%B9%98)
3. [Deployment 생성](https://github.com/tmax-cloud/install-OLM/blob/main/README.md#step-3-%EB%8F%99%EC%9E%91-%ED%99%95%EC%9D%B8)

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
1. [Deployment 삭제](https://github.com/tmax-cloud/install-OLM/blob/main/README.md#step-1-%EC%82%AC%EC%9A%A9%EC%A4%91%EC%9D%B8-%EB%A6%AC%EC%86%8C%EC%8A%A4-%EC%A0%9C%EA%B1%B0)
2. [RBAC 삭제](https://github.com/tmax-cloud/install-OLM/blob/main/README.md#step-2-%EC%84%A4%EC%B9%98-%EC%A0%9C%EA%B1%B0)
3. [CRD 제거](https://github.com/tmax-cloud/install-OLM/blob/main/README.md#step-3-crd-%EC%A0%9C%EA%B1%B0)
4. [Namespace 제거]

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
