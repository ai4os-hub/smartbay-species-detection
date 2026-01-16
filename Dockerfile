# Dockerfile may have following Arguments:
# tag - tag for the Base image, (e.g. 2.9.1 for tensorflow)
#
# To build the image:
# $ docker build -t <dockerhub_user>/<dockerhub_repo> --build-arg arg=value .
# or using default args:
# $ docker build -t <dockerhub_user>/<dockerhub_repo> .
#
# Be Aware! For the Jenkins CI/CD pipeline, 
# input args are defined inside the JenkinsConstants.groovy, not here!

ARG tag=latest

# Base image, e.g. tensorflow/tensorflow:2.9.1
FROM ai4oshub/ai4os-yolo-torch:${tag}

LABEL maintainer='Damian Smyth, Eva Cullen, Eabha Melvin'
LABEL version='0.0.1'
# AI-based Marine Species detection and classification algorithm based on YOLOv8. The model has been tuned to detect and classify marine species at the Smartbay underwater observatory.

# Download new model weights and remove old ones
# You can use the following as "reference" - https://github.com/ai4os-hub/ai4os-image-classification-tf/blob/master/Dockerfile
###############
### FILL ME ###
###############
ENV YOLO_DEFAULT_WEIGHTS="yolov8_smartbay_species_small"
ENV YOLO_DEFAULT_TASK_TYPE="det"

# Uninstall existing module ("ai4os_yolo")
# Update MODEL_NAME to smartbay_species_detection
# Copy updated pyproject.toml to include Smartbay authors and rename the module
# Re-install application with the updated pyproject.toml
RUN cd /srv/ai4os-yolo-torch && \
    module=$(cat pyproject.toml |grep '\[project\]' -A1 |grep 'name' | cut -d'=' -f2 |tr -d ' ' |tr -d '"') && \
    pip uninstall -y $module
ENV MODEL_NAME="smartbay_species_detection"
COPY ./pyproject-child.toml /srv/ai4os-yolo-torch/pyproject.toml
RUN cd /srv/ai4os-yolo-torch && pip install --no-cache -e .

RUN mkdir -p /srv/ai4os-yolo-torch/models/yolov8_smartbay_species_small/weights && \
    curl -L https://zenodo.org/records/15390169/files/smartbay-species-model-yolo8s.pt \
    --output /srv/ai4os-yolo-torch/models/yolov8_smartbay_species_small/weights/best.pt
