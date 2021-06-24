# tfc-operator 설치 가이드

## 구성 요소 및 버전
* tfc-operator
	* image: [tmaxcloudck/tfc-operator:b5.0.16.0](https://hub.docker.com/layers/tmaxcloudck/tfc-operator/b5.0.1.0/images/sha256-4e65c5f02a4c9833d6e196a53996ae918bc05a180794e716b9b869a1228cd868?context=explore)
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
    $ export TFC_VERSION=b5.0.16.0
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
    $ git clone -b 5.0 https://github.com/tmax-cloud/install-tfc-operator.git
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
0. [tfc-operator Config 설정](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-0-tfc-operator-config-%EC%84%A4%EC%A0%95)
1. [installer 실행](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-1-installer-%EC%8B%A4%ED%96%89)

## Step 0. tfc-operator Config 설정
* 목적 : `version.conf 파일에 설치를 위한 정보 기입`
* 순서 : 환경에 맞는 config 내용 작성

## Step 1. installer 실행
* 목적 : `설치를 위한 shell script 실행`
* 순서 : 권한 부여 및 실행
    ```bash
     $ sudo chmod +x install.sh
     $ ./install.sh
    ```

## 삭제 가이드
1. [uninstaller 실행](https://github.com/tmax-cloud/install-tfc-operator/blob/5.0/README.md#step-1-uninstaller-%EC%8B%A4%ED%96%89)

## Step 1. uninstaller 실행
* 목적 : `tfc-operator를 삭제하기 위한 uninstaller 실행`
* 순서 : 권한 부여 및 실행
    ```bash
     $ sudo chmod +x uninstall.sh
     $ ./uninstall.sh
    ```
