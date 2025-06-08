FROM ubuntu:22.04

# Installer tshark et Python
RUN apt-get update && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y tshark python3 python3-pip && \
    apt-get clean && rm -rf /var/lib/apt/lists/*

# Copier le script Python dans le conteneur (si tu en as un)
COPY capture_tshark.py /app/capture_tshark.py

WORKDIR /app

# Rendre tshark utilisable sans interaction (autoriser capture)
RUN setcap cap_net_raw,cap_net_admin=eip $(which dumpcap)

ENTRYPOINT ["python3", "capture_tshark.py"]
