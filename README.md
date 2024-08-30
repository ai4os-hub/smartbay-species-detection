# smartbay-species-detection
[![Build Status](https://jenkins.services.ai4os.eu/buildStatus/icon?job=AI4OS-hub/smartbay-species-detection/main)](https://jenkins.services.ai4os.eu/job/AI4OS-hub/job/smartbay-species-detection/job/main/)

AI-based Marine Species detection and classification algorithm based on YOLOv8. The model has been tuned to detect and classify marine species at the Smartbay underwater observatory.

This is a container that will run the smartbay-species-detection application leveraging the DEEP as a Service API component ([DEEPaaS API](https://github.com/ai4os/DEEPaaS)). The application is based on **ai4oshub/ai4os-yolov8-torch** module.

    
## Running the container

### Directly from Docker Hub

To run the Docker container directly from Docker Hub and start using the API, simply run the following command:

```bash
$ docker run -ti -p 5000:5000 -p 6006:6006 -p 8888:8888 ai4oshub/smartbay-species-detection
```

This command will pull the Docker container from the Docker Hub [ai4oshub](https://hub.docker.com/u/ai4oshub/) repository and start the default command (`deepaas-run --listen-ip=0.0.0.0`).

**N.B.** For either CPU-based or GPU-based images you can also use [udocker](https://github.com/indigo-dc/udocker).

### Building the container

If you want to build the container directly in your machine (because you want to modify the `Dockerfile` for instance) follow the following instructions:
```bash
git clone https://github.com/ai4os-hub/smartbay-species-detection/smartbay-species-detection
cd smartbay-species-detection
docker build -t ai4oshub/smartbay-species-detection .
docker run -ti -p 5000:5000 -p 6006:6006 -p 8888:8888 ai4oshub/smartbay-species-detection
```

These three steps will download the repository from GitHub and will build the Docker container locally on your machine. You can inspect and modify the `Dockerfile` in order to check what is going on. For instance, you can pass the `--debug=True` flag to the `deepaas-run` command, in order to enable the debug mode.


## Connect to the API

Once the container is up and running, browse to http://0.0.0.0:5000/ui to get the [OpenAPI (Swagger)](https://www.openapis.org/) documentation page.


## Project structure
```
├─ Dockerfile             <- Describes main steps on integration of DEEPaaS API and
│                            <your_project> application in one Docker image
│
├─ Jenkinsfile            <- Describes basic Jenkins CI/CD pipeline
│
├─ LICENSE                <- License file
│
├─ README.md              <- README for developers and users
│
├── .sqa/                 <- CI/CD configuration files
│
└─ ai4-metadata.yml       <- Defines information propagated to the AI4OS Hub
```

You can validate the `ai4-metadata.yml` before making a git push using:
```shell
pip install yq
pip install ai4-metadata
yq -e -j ai4-metadata.yml >ai4-metadata.json
ai4-metadata validate ai4-metadata.json
```
