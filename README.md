# Docker-Base
Base of the DockerFile

# Image

---

Dockerfile이 작성되었으므로 Dockerfile이 있는 폴더에서 다음의 명령어를 실행합니다.

## Example

```bash
docker build -t test --build-arg UNAME=${NAME} --build-arg UID=${UID} --build-arg GID=${UID} .
```

`-t` : 생성할 image의 이름입니다.

`--build-arg` : Dockerfile에서 사용하는 `ARG` 에 전달할 값에 해당합니다. 참고로 `UID` 및 `GID` 는 Ubuntu의 `id` 커맨드를 통해 확인할 수 있습니다. `NAME`은 우분투 유저 이름입니다.

# Container

---

Image를 기반으로 Container를 생성합니다. 

## Example

```bash
docker run --gpus all -it -p 8080:8888 -u $(id -u):$(id -g) -v ~/${Workspace src}:/${Workspace dest} --name cont_test -id test
```

`--gpus all` : 해당 docker에서 모든 GPU resource를 접근할 수 있도록 합니다.

`-p` : port정보입니다. colon기준으로 앞의 숫자는 host PC의 port이며 뒤의 숫자는 컨테이너 내부의 port입니다. 즉, 위의 예시에서 host PC의 8080포트접근은 container 8888포트로 연결됩니다.

`-it` : `i` 는 interactive option으로 `STDIN` 을 사용할 수 있도록 해주며 `t` 는 pseudo-TTY로 두 option을 사용해 container 밖에서도 container에서 커맨드르 실행할 수 있게 해줍니다.

`--name` : container의 이름입니다.

`-id` : container를 생성하는데 사용할 image입니다. 앞서 image에 부여한 이름을 지정해주면 됩니다.

`-v` : container에 mount할 파일

구체적인 예시

```bash
docker run --gpus all -it -p 8989:8989 -u $(id -u):$(id -g) -v /home/taerim:/home/taerim --name reacher -id 2672aead2725
```

---

## Docker로 Run하기

```bash
docker run -it -d --name ${container name}  -v ~/${Workspace src}:/${Workspace dest} ${image name} /bin/bash
```

example

```bash
docker run -it -d --name taerim -v /home/taerim:/home/taerim pytorch/pytorch:1.12.0-cuda11.3-cudnn8-runtime /bin/bash
```

## Docker로 실행하기

```bash
docker exec -it ${container name} /bin/bash 
```

# Continerd의 root로 들어가기

```bash
docker exec -u 0 -it <MyContainer> bash
```
