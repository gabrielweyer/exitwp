FROM python:2.7.14-stretch

ENV WORK_DIR /exitwp/

WORKDIR $WORK_DIR

COPY config.yaml $WORK_DIR
COPY exitwp.py $WORK_DIR
COPY html2text.py $WORK_DIR
COPY pip_requirements.txt $WORK_DIR

RUN apt-get update -q
RUN apt-get install libyaml-dev python-dev build-essential -y -q
RUN pip install --upgrade -r /exitwp/pip_requirements.txt

ENTRYPOINT ["python", "/exitwp/exitwp.py"]
