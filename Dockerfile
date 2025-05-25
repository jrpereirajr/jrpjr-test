ARG IMAGE=intersystemsdc/irishealth-community
ARG IMAGE=intersystemsdc/iris-community:preview
ARG IMAGE=intersystemsdc/iris-community
ARG IMAGE=intersystemsdc/irishealth-ml-community:latest
FROM $IMAGE

# USER root

# RUN apt-get update && apt-get install nano

# USER $IRIS_USERNAME

WORKDIR /home/irisowner/dev

ARG TESTS=0
ARG MODULE="jrpjr-test"
ARG NAMESPACE="USER"

# create Python env
## Embedded Python environment
ENV IRISNAMESPACE "IRISAPP"
ENV PYTHON_PATH=/usr/irissys/bin/
ENV PATH "/usr/irissys/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/home/irisowner/bin:/home/irisowner/.local/bin"
# ENV LIBRARY_PATH=${ISC_PACKAGE_INSTALLDIR}/bin:${LIBRARY_PATH}
## Start IRIS

# RUN --mount=type=bind,src=.,dst=. \
#     pip3 install -r requirements.txt && \
#     iris start IRIS && \
#     iris merge IRIS merge.cpf && \
#     irispython iris_script.py && \
#     iris stop IRIS quietly
RUN --mount=type=bind,src=.,dst=. 
RUN pip3 install -r requirements.txt 
RUN iris start IRIS 
RUN iris merge IRIS merge.cpf 
RUN irispython iris_script.py 
RUN iris stop IRIS quietly
