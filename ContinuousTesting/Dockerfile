# Use Ubuntu as the base image
FROM ubuntu:20.04

# Set environment variables to prevent prompts during installation
ENV DEBIAN_FRONTEND=noninteractive
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

# Update and install essential packages
RUN apt-get update && apt-get install -y \
    openjdk-8-jdk \
    build-essential \
    wget \
    unzip \
    libncurses5-dev \
    libhts-dev \
    libbz2-dev \
    git \
    bzip2 \
    && apt-get clean

# Install FastQC
RUN wget https://www.bioinformatics.babraham.ac.uk/projects/fastqc/fastqc_v0.11.7.zip && \
    unzip fastqc_v0.11.7.zip && \
    chmod +x FastQC/fastqc && \
    ln -s /FastQC/fastqc /usr/local/bin/fastqc

# Install seqtk
RUN git clone https://github.com/lh3/seqtk.git && \
    cd seqtk && \
    git checkout tags/v1.3 && \
    make && \
    cp seqtk /usr/local/bin/ && \
    cd .. && rm -rf seqtk

# Install BWA
RUN wget https://github.com/lh3/bwa/archive/refs/tags/v0.7.17.tar.gz && \
    tar -xzf v0.7.17.tar.gz && \
    cd bwa-0.7.17 && \
    make && \
    cp bwa /usr/local/bin/ && \
    cd .. && rm -rf bwa-0.7.17 v0.7.17.tar.gz

# Install Samtools v1.9
RUN wget https://github.com/samtools/samtools/releases/download/1.9/samtools-1.9.tar.bz2 && \
    tar -xjf samtools-1.9.tar.bz2 && \
    cd samtools-1.9 && \
    make && \
    cp samtools /usr/local/bin/ && \
    cd .. && rm -rf samtools-1.9 samtools-1.9.tar.bz2

# Install Picard
RUN mkdir /Picard && \
    cd /Picard && \
    wget https://github.com/broadinstitute/picard/releases/download/2.18.3/picard.jar && \
    echo 'java -jar /Picard/picard.jar CreateSequenceDictionary REFERENCE=$1 OUTPUT=$2' >> /usr/local/bin/picard && \
    chmod +x /usr/local/bin/picard

# Set environment variables
ENV PATH="/opt/notebooks/Picard:$PATH"

# Install Miniconda
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh && \
    bash Miniconda3-latest-Linux-x86_64.sh -b -p /opt/miniconda && \
    rm Miniconda3-latest-Linux-x86_64.sh

# Set PATH to use conda
ENV PATH="/opt/miniconda/bin:$PATH"

RUN conda create -y -n scalenv python=3.12.8 && \
    /opt/miniconda/bin/conda run -n scalenv pip install --upgrade pip && \
    conda install -n scalenv -c bioconda freebayes -y

# Clone and install ScaleHD inside conda environment
RUN /opt/miniconda/bin/conda run -n scalenv bash -c "\
    git clone https://github.com/MoncktonLab/ScaleHD.git && \ 
    cd ScaleHD/src && \
    python setup.py install"

# Make conda env the default Python
ENV PATH="/opt/miniconda/envs/scalenv/bin:$PATH"


# Copy test script
COPY run_scalehd_tests.sh run_scalehd_tests.sh

# Copy test data and references
COPY FastqFiles/ScaleHDTestData_10kMiSeq_R1.fastq.gz MiSeq_runX/FastqFiles/ScaleHDTestData_10kMiSeq_R1.fastq.gz
COPY FastqFiles/ScaleHDTestData_10kMiSeq_R2.fastq.gz MiSeq_runX/FastqFiles/ScaleHDTestData_10kMiSeq_R2.fastq.gz
COPY References/4k-HD-INTER.fa MiSeq_runX/References/4k-HD-INTER.fa
COPY References/4k-HD-Reverse.fasta MiSeq_runX/References/4k-HD-Reverse.fasta
COPY ConfigurationFile_MiSeq_runX.xml MiSeq_runX/ConfigurationFile_MiSeq_runX.xml
COPY scalehd_test_expected_checksums.csv MiSeq_runX/scalehd_test_expected_checksums.csv

# Set working directory
WORKDIR /

# Make test script executable
RUN chmod +x run_scalehd_tests.sh


# Default command: open interactive shell
CMD ["/bin/bash"]
