FROM eclipse-temurin:11-jre

# ---------------------------
# System dependencies
# ---------------------------
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 \
        python3-pip \
        curl \
    && rm -rf /var/lib/apt/lists/* \
    && ln -s /usr/bin/python3 /usr/bin/python

# ---------------------------
# Python environment
# ---------------------------
RUN pip install --upgrade pip && \
    pip install \
        pyspark==3.5.3 \
        jupyterlab \
        pandas \
        pyarrow

# ---------------------------
# Spark
# ---------------------------
ARG SPARK_VERSION=3.5.3
ARG HADOOP_VERSION=3

ENV SPARK_HOME=/opt/spark
ENV PATH=$PATH:$SPARK_HOME/bin
ENV PYSPARK_PYTHON=/usr/bin/python3

RUN curl -L "https://archive.apache.org/dist/spark/spark-${SPARK_VERSION}/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION}.tgz" \
    | tar -xz -C /opt && \
    mv /opt/spark-${SPARK_VERSION}-bin-hadoop${HADOOP_VERSION} $SPARK_HOME

WORKDIR /opt/notebooks

EXPOSE 8888 4040

CMD ["jupyter-lab", "--ip=0.0.0.0", "--port=8888", "--no-browser", "--allow-root"]
