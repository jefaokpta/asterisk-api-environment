FROM debian:12

ENV DEBIAN_FRONTEND=noninteractive

COPY ./asterisk-18-current.tar.gz /

RUN apt-get update \
&& tar -zxf asterisk-18-current.tar.gz \
&& rm asterisk-18-current.tar.gz \
&& cd $(ls |grep asterisk) \
&& contrib/scripts/install_prereq install \
&& ./configure \
&& apt-get clean 

RUN cd $(ls |grep asterisk) \
&& make menuselect.makeopts \
&& menuselect/menuselect \
--enable BUILD_NATIVE \
#CHANNELS
--disable chan_sip \
--disable chan_skinny \
--disable chan_oss \
--disable chan_mgcp \
--disable chan_motif \
--disable chan_dahdi \
--disable chan_alsa \
--disable chan_unistim \
#PBX MODULES
--disable pbx_loopback \
--disable pbx_spool \
--disable pbx_ael \
--disable pbx_dundi \
--disable pbx_lua \
--disable pbx_realtime \
#RESOURCES
--disable res_adsi \
--disable res_config_odbc \
--disable res_config_sqlite3 \
--disable res_config_pgsql \
--disable res_odbc \
--disable res_odbc_transaction \
--disable res_monitor \
#APPS
--disable app_adsiprog \
--disable app_ices \
--disable app_osplookup \
--disable app_image \
--disable app_url \
--disable app_nbscat \
--disable app_getcpeid \
#CDR MODULES
--disable cdr_adaptive_odbc \
--disable cdr_odbc \
--disable cdr_pgsql \
--disable cdr_radius \
--disable cdr_sqlite3_custom \
--disable cdr_tds \
#CEL MODULES
--disable cel_odbc \
--disable cel_pgsql \
--disable cel_radius \
--disable cel_sqlite3_custom \
--disable cel_tds \
menuselect.makeopts \
&& make \
&& make install
# && make samples \
#&& cd ../ && rm -r asterisk*

# COPY ./libmyodbc8a.so /usr/lib/x86_64-linux-gnu/odbc/
# COPY odbc.ini /etc
# COPY odbcinst.ini /etc

#ENTRYPOINT [ "/usr/sbin/asterisk", "-mqf"]
CMD [ "/usr/sbin/asterisk", "-mqf"]
