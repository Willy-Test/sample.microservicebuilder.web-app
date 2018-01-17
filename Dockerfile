FROM websphere-liberty:webProfile7
COPY server.xml /opt/ibm/wlp/usr/servers/defaultServer/server.xml
COPY com.ibm.apm.dataCollector-7.4.esa /opt/
# Install required features if not present
RUN installUtility install --acceptLicense defaultServer && installUtility install --acceptLicense /opt/com.ibm.apm.dataCollector-7.4.esa
#RUN installUtility install --acceptLicense defaultServer && installUtility install --acceptLicense apmDataCollector-7.4
RUN /bin/sh -c "/opt/ibm/wlp/usr/extension/liberty_dc/bin/config_liberty_dc.sh -slient /opt/ibm/wlp/usr/extension/liberty_dc/bin/slient_config_liberty_dc.txt"
COPY target /opt/ibm/wlp/usr/servers/defaultServer/apps/
RUN mv /opt/ibm/wlp/usr/servers/defaultServer/apps/web-application-1.0.0-SNAPSHOT.war /opt/ibm/wlp/usr/servers/defaultServer/apps/web-app.war
