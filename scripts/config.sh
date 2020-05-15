#!/bin/sh -e
# (c) 2018-2019 Cloudera, Inc. All rights reserved.
#
#  This code is provided to you pursuant to your written agreement with Cloudera, which may be the terms of the
#  Affero General Public License version 3 (AGPLv3), or pursuant to a written agreement with a third party authorized
#  to distribute this code.  If you do not have a written agreement with Cloudera or with an authorized and
#  properly licensed third party, you do not have any rights to this code.
#
#  If this code is provided to you under the terms of the AGPLv3:
#   (A) CLOUDERA PROVIDES THIS CODE TO YOU WITHOUT WARRANTIES OF ANY KIND;
#   (B) CLOUDERA DISCLAIMS ANY AND ALL EXPRESS AND IMPLIED WARRANTIES WITH RESPECT TO THIS CODE, INCLUDING BUT NOT
#       LIMITED TO IMPLIED WARRANTIES OF TITLE, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE;
#   (C) CLOUDERA IS NOT LIABLE TO YOU, AND WILL NOT DEFEND, INDEMNIFY, OR HOLD YOU HARMLESS FOR ANY CLAIMS ARISING
#       FROM OR RELATED TO THE CODE; AND
#   (D) WITH RESPECT TO YOUR EXERCISE OF ANY RIGHTS GRANTED TO YOU FOR THE CODE, CLOUDERA IS NOT LIABLE FOR ANY
#       DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, PUNITIVE OR CONSEQUENTIAL DAMAGES INCLUDING, BUT NOT LIMITED
#       TO, DAMAGES RELATED TO LOST REVENUE, LOST PROFITS, LOSS OF INCOME, LOSS OF BUSINESS ADVANTAGE OR
#       UNAVAILABILITY, OR LOSS OR CORRUPTION OF DATA.

# Incorporate helper functions
#. /opt/commons/commons.sh

#export properties_file='/opt/c2/c2-1.0.0-SNAPSHOT/conf/c2.properties'

# Nothing to do, all ENV overrides are applied by the application
#azure nars

scripts_dir='/opt/scripts'

[ -f "${scripts_dir}/common.sh" ] && . "${scripts_dir}/common.sh"

export minifi_props_file=${MINIFI_HOME}/conf/nifi.properties
export minifi_conf_file=${MINIFI_HOME}/conf/bootstrap.conf


#wget -P ${MINIFI_HOME}/lib/ https://sunileman.s3.amazonaws.com/CEM/minifi_nars/nifi-azure-nar-1.8.0.3.3.1.0-10.nar
#wget -P ${MINIFI_HOME}/lib/ https://sunileman.s3.amazonaws.com/CEM/minifi_nars/nifi-standard-services-api-nar-1.8.0.3.3.1.0-10.nar
#wget -P ${MINIFI_HOME}/lib/ https://sunileman.s3.amazonaws.com/CEM/minifi_nars/minifi_nars/nifi-http-context-map-nar-1.8.0.3.3.1.0-10.nar

#aws nars
#wget -P ${MINIFI_HOME}/lib/ https://sunileman.s3.amazonaws.com/CEM/minifi_nars/nifi-aws-service-api-nar-1.8.0.3.3.1.0-10.nar
#wget -P ${MINIFI_HOME}/lib/ https://sunileman.s3.amazonaws.com/CEM/minifi_nars/nifi-aws-nar-1.8.0.3.3.1.0-10.nar

if [ ! -z "${NIFI_C2_ENABLE}" ]; then
    uncomment "nifi.c2.enable"
fi

if [ ! -z "${MINIFI_AGENT_CLASS}" ]; then
    uncomment "nifi.c2.agent.class"
fi

if [ ! -z "${NIFI_C2_REST_URL}" ]; then
    uncomment "nifi.c2.rest.url"
fi

if [ ! -z "${NIFI_C2_REST_URL_ACK}" ]; then
    uncomment "nifi.c2.rest.url.ack"
fi

if [ ! -z "${NIFI_C2_SEC_TRUSTSTORE_LOC}" ]; then
    uncomment "nifi.c2.security.truststore.location"
fi

if [ ! -z "${NIFI_C2_SEC_TRUSTSTORE_PASSWORD}" ]; then
    uncomment "nifi.c2.security.truststore.password"
fi

if [ ! -z "${NIFI_C2_SEC_TRUSTSTORE_TYPE}" ]; then
    uncomment "nifi.c2.security.truststore.type"
fi

if [ ! -z "${NIFI_C2_SEC_KEYSTORE_LOC}" ]; then
    uncomment "nifi.c2.security.keystore.location"
fi

if [ ! -z "${NIFI_C2_SEC_KEYSTORE_PASSWORD}" ]; then
    uncomment "nifi.c2.security.keystore.password"
fi

if [ ! -z "${NIFI_C2_SEC_KEYSTORE_TYPE}" ]; then
    uncomment "nifi.c2.security.keystore.type"
fi

if [ ! -z "${NIFI_C2_SEC_NEED_CLIENT_AUTH}" ]; then
    uncomment "nifi.c2.security.need.client.auth"
fi

if [ ! -z "${JVM_ARGS_13}" ]; then
    uncomment "java.arg.13"
fi

prop_replace 'nifi.c2.enable' "${NIFI_C2_ENABLE:-false}"

prop_replace 'nifi.c2.agent.class' "${MINIFI_AGENT_CLASS}"

prop_replace 'nifi.c2.rest.url' "${NIFI_C2_REST_URL}"

prop_replace 'nifi.c2.rest.url.ack' "${NIFI_C2_REST_URL_ACK}"

prop_replace 'nifi.c2.agent.heartbeat.period' "${HEARTBEAT:-1000}"

prop_replace 'java.arg.2' "${JVM_ARGS_2:--Xms512m}"

prop_replace 'java.arg.2' "${JVM_ARGS_3:--Xms512m}"

prop_replace 'java.arg.2' "${JVM_ARGS_3:--Xms512m}"

prop_replace 'run.as' "${RUN_AS}"

prop_replace 'nifi.c2.security.truststore.location' "${NIFI_C2_SEC_TRUSTSTORE_LOC}"

prop_replace 'nifi.c2.security.truststore.password' "${NIFI_C2_SEC_TRUSTSTORE_PASSWORD}"

prop_replace 'nifi.c2.security.truststore.type' "${NIFI_C2_SEC_TRUSTSTORE_TYPE:-JKS}"

prop_replace 'nifi.c2.security.keystore.location' "${NIFI_C2_SEC_KEYSTORE_LOC}"

prop_replace 'nifi.c2.security.keystore.password' "${NIFI_C2_SEC_KEYSTORE_PASSWORD}"

prop_replace 'nifi.c2.security.keystore.type' "${NIFI_C2_SEC_KEYSTORE_TYPE:-JKS}"

prop_replace 'nifi.c2.security.need.client.auth' "${NIFI_C2_SEC_NEED_CLIENT_AUTH:-true}"

prop_replace 'java.arg.13' "${JVM_ARGS_13:-XX:+UseG1GC}"

prop_replace 'nifi.provenance.repository.implementation' "${NIFI_PROV_REPO_IMPL:-org.apache.nifi.provenance.MiNiFiPersistentProvenanceRepository}"

prop_replace 'nifi.provenance.repository.rollover.time' "${NIFI_PROV_REPO_RV_TIME:-1 min}"


#prop_replace 'nifi.security.keystore' "${NIFI_SEC_KEYSTORE}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.keystoreType' "${NIFI_SEC_KEYSTORE_TYPE}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.keystorePasswd' "${NIFI_SEC_KEYSTORE_PASSWD}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.keyPasswd' "${NIFI_SEC_KEY_PASSWD}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.truststore' "${NIFI_SEC_TRUSTSTORE}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.truststoreType' "${NIFI_SEC_TRUSTSTORE_TYPE}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.truststorePasswd' "${NIFI_SEC_TRUSTSTORE_PASSWORD}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.needClientAuth' "${NIFI_SEC_NEED_CLIENT_AUTH}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.needClientAuth' "${NIFI_SEC_NEED_CLIENT_AUTH}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.user.credential.cache.duration' "${NIFI_SEC_USR_CRED_CACHE_DUR:-24 hours}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.user.authority.provider' "${NIFI_SEC_USR_AUTH_PROV:-file-provider}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.user.login.identity.provider' "${NIFI_SEC_USR_LOGIN_ID_PROV}" ${MINIFI_HOME}/conf/nifi.properties

#prop_replace 'nifi.security.support.new.account.requests' "${NIFI_SEC_SUP_NEW_ACC_REQ}" ${MINIFI_HOME}/conf/nifi.properties




