# tang-server

Container image for running a [Tang server](https://github.com/latchset/tang) on Kubernetes

## Usage

- Build image: `docker build --platform linux/amd64,linux/arm64 -t cisnerosf/tang-server:1.0 .`
- Publish image: `docker push cisnerosf/tang-server:1.0`
- Deploy on Kubernetes: `kubectl apply -f k8s.yml`
