FROM ubuntu:16.04

MAINTAINER Grossmann Tim <contact.timgrossmann@gmail.com>

# Set env variables
ENV CHROME https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb
ENV CRHOMEDRIVER http://chromedriver.storage.googleapis.com/2.45/chromedriver_linux64.zip

# Environment setup
RUN apt-get update \
    && apt-get -y upgrade \
    && apt-get -y install \
        apt-utils \
        locales \
        unzip \
        python3-pip \
        python3-dev \
        build-essential \
        libssl-dev \
        libffi-dev \
        xvfb \
        wget \
        git \
        sed \
        fonts-liberation \
        libappindicator1 \
        libasound2 \
        libatk1.0-0 \
        libgconf2-4 \
        libnss3-1d \
        libxss1 \
        libcurl3 \
        gconf-service \
        libcairo2 \
        libcups2 \
        libfontconfig1 \
        libgdk-pixbuf2.0-0 \
        libgtk2.0-0 \
        libpango1.0-0 \
        libxcomposite1 \
        libxtst6 \
        xdg-utils \
        lsb-release \
    && python3 -m pip install --upgrade pip \
    && locale-gen en_US.UTF-8 \
    && dpkg-reconfigure locales \
    && python3 -m pip install --upgrade pip \
    && apt-get -f install

ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LC_ALL en_US.UTF-8

# Installing latest chrome
RUN cd ~ \
    && wget ${CHROME} \
    && dpkg -i google-chrome-stable_current_amd64.deb \
    && apt-get install -y -f \
    && rm google-chrome-stable_current_amd64.deb

# Cleanup
RUN apt-get clean \
	&& rm -rf /var/lib/apt/lists/*

# Adding InstaPy
RUN git clone https://github.com/timgrossmann/InstaPy.git \
    && sed -i -e "s/log_location.*/log_location = os.path.join(BASE_DIR, 'persistent', 'logs')/" \
    -e "s/database_location.*/database_location = os.path.join(BASE_DIR, 'persistent', 'db', 'instapy.db')/" InstaPy/instapy/settings.py \
    && wget ${CRHOMEDRIVER} \
    && unzip chromedriver_linux64 \
    && mkdir InstaPy/assets/ \
    && mv chromedriver InstaPy/assets/chromedriver \
    && chmod +x InstaPy/assets/chromedriver \
    && chmod 755 InstaPy/assets/chromedriver \
    && cd InstaPy \
    && pip install .

# Setting work directory
WORKDIR /InstaPy

CMD ["python3.5", "./persistent/quickstart.py"]
