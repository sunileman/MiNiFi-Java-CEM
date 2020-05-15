FROM openjdk:8-jdk-alpine

ARG UID=1000
ARG GID=1000


ARG MINIFI_VERSION_ARG=0.6.0.1.1.0.0-172
ARG GET_AZURE_LIB=N
ARG GET_AWS_LIB=N


ENV MINIFI_VERSION=$MINIFI_VERSION_ARG


ENV MINIFI_BASE_DIR=/opt/minifi
ENV MINIFI_SCRIPTS=/opt/scripts
ENV MINIFI_HOME=$MINIFI_BASE_DIR/minifi-$MINIFI_VERSION

RUN apk add --no-cache bash wget

# Setup MiNiFi user
RUN addgroup -g $GID minifi || groupmod -n minifi `getent group $GID | cut -d: -f1`
RUN adduser -S -H -G minifi minifi
RUN mkdir -p $MINIFI_BASE_DIR
RUN mkdir -p $MINIFI_SCRIPTS


ADD ./scripts $MINIFI_SCRIPTS

RUN wget https://sunileman.s3.amazonaws.com/CEM/Java-minifi/minifi-$MINIFI_VERSION-bin.tar.gz -P $MINIFI_BASE_DIR


run tar -xzf $MINIFI_BASE_DIR/minifi-$MINIFI_VERSION-bin.tar.gz -C $MINIFI_BASE_DIR

run rm -f $MINIFI_BASE_DIR/minifi-$MINIFI_VERSION-bin.tar.gz


RUN chown -R minifi:minifi $MINIFI_BASE_DIR
RUN chown -R minifi:minifi $MINIFI_SCRIPTS

USER minifi

#Get some base minifi nars
RUN if [ "$GET_AZURE_LIB" = "Y" ]; then wget https://sunileman.s3.amazonaws.com/CEM/minifi_nars/nifi-standard-services-api-nar-1.8.0.3.3.1.0-10.nar -P ${MINIFI_HOME}/lib/ ; fi
RUN if [ "$GET_AWS_LIB" = "Y" ]; then wget https://sunileman.s3.amazonaws.com/CEM/minifi_nars/nifi-http-context-map-nar-1.8.0.3.3.1.0-10.nar -P ${MINIFI_HOME}/lib/ ; fi


#RUN wget https://sunileman.s3.amazonaws.com/CEM/minifi_nars/nifi-standard-services-api-nar-1.8.0.3.3.1.0-10.nar -P ${MINIFI_HOME}/lib/
#RUN wget https://sunileman.s3.amazonaws.com/CEM/minifi_nars/nifi-http-context-map-nar-1.8.0.3.3.1.0-10.nar -P ${MINIFI_HOME}/lib/



RUN ["chmod", "+x", "/opt/scripts/config.sh"]
RUN ["chmod", "+x", "/opt/scripts/start.sh"]

CMD ${MINIFI_SCRIPTS}/start.sh
