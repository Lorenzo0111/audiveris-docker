FROM ubuntu:24.04

RUN apt-get update && apt-get install -y  \
        curl \
        wget \
        git \
        tesseract-ocr \
        tesseract-ocr-eng \
        tesseract-ocr-deu \
        tesseract-ocr-fra \
        openjdk-21-jdk

RUN wget https://github.com/Audiveris/audiveris/releases/download/5.10.2/Audiveris-5.10.2-ubuntu24.04-x86_64.deb && \
    dpkg-divert --local --rename --add /usr/bin/xdg-desktop-menu && \
    ln -s /bin/true /usr/bin/xdg-desktop-menu && \
    apt-get install -y ./Audiveris-5.10.2-ubuntu24.04-x86_64.deb && \
    rm /usr/bin/xdg-desktop-menu && \
    dpkg-divert --local --rename --remove /usr/bin/xdg-desktop-menu && \
    rm Audiveris-5.10.2-ubuntu24.04-x86_64.deb

CMD ["sh", "-c", "Audiveris -batch -export -output /output/ $(ls /input/*.jpg /input/*.png /input/*.pdf)"]