# The line below states we will base our new image on the 16.04 Ubuntu
FROM ubuntu:16.04

# Hello World
RUN echo "logwatch/botApp:v1" \
&& echo "author: Minkyu Choi" \
&& echo "date: 2019/05/20"

# Identify the maintainer of an image
LABEL maintainer="minkyu choi"

# Update the image to the latest packages
RUN echo "updating apt-get " \
 && apt -q update -y \
 && apt -q upgrade -y \ 
 && apt -q install wget -y \ 
 && apt -q install locales \ 
 && echo "ubunut set up completed"

# Install Python & Library
RUN echo "Installing Python and libraries " \ 
 && apt -q install python3 python3-pip -y \   
 && pip3 install slack-machine \
 && echo "python set up completed"

RUN cd /home \
 && mkdir slack_bot \
 && cd slack_bot \
 && mkdir plugins \
 && > plugins/__init__.py \
 && echo "Downloading local_setting python script from Git " \ 
 && wget https://raw.githubusercontent.com/mchoi07/logwatch_kubernetes/master/bot/local_settings.py \
 && cd plugins \
 && echo "Downloading plugin python script from Git" \
 && wget https://raw.githubusercontent.com/mchoi07/logwatch_kubernetes/master/bot/plugins/log.py \
 && cd .. \
 && locale-gen en_US.utf8 \ 
 && update-locale LANG=en_US.utf8 \ 
 && export LC_ALL=en_US.utf8 \ 
 && echo "All Environments have been set up"

ENV SLACK_API_TOKEN " "

# Set up the starting sh file 
COPY start.sh /home/slack_bot/start.sh 

# Finalize the process
CMD ["sh", "-c", "/home/slack_bot/start.sh"]

