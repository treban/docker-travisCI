##################################################################
# travis-CI docker file
# VERSION               0.1
##################################################################

# base image
FROM quay.io/travisci/travis-jvm

LABEL Description="Travis CI docker image" Maintainer="trebankosta@gmail.com" Version="0.1"

####### install #######
RUN rvm install 2.3.0
RUN rvm use 2.3.0

RUN cd ~./builds
RUN git clone https://github.com/travis-ci/travis-build.git
RUN cd travis-build ; gem install travis 
RUN travis ; ln -s `pwd` ~./travis/travis-build
RUN bundle install

####### start #######
CMD cd ~/builds && mkdir $AUTHOR && cd $AUTHOR \
 && git clone https://github.com/$AUTHOR/$PROJECT.git \
 && cd $PROJECT \
 && travis compile > ci.sh \
 && bash ci.sh
