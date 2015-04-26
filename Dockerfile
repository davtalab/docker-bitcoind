FROM systemd-unpriv

RUN yum groups mark convert
RUN yum group install -y "Development Tools"
#RUN yum group install -y "C Development Tools and Libraries"
RUN yum install -y sudo vim git openssh-server openssh-clients openssl openssl-devel boost-devel dh-autoreconf ccache pkgconfig libdb libdb-devel libdb-cxx libdb-cxx-devel protobuf protobuf-devel

#now we build bitcoin from source
RUN useradd -mc "Bit₵oin U$er" bitcoin -p abioytFqlXVrA
#RUN usermod -G sudo bitcoin
RUN echo 'bitcoin ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
RUN git clone -b 0.9 git://github.com/bitcoin/bitcoin.git /home/bitcoin/bitcoin
RUN git clone -b OpenSSL_1_0_2-stable https://github.com/openssl/openssl.git /home/bitcoin/openssl

RUN cd /home/bitcoin/openssl && ./config --prefix=/usr shared enable-ec enable-ecdh enable-ecdsa
RUN cd /home/bitcoin/openssl && make
RUN cd /home/bitcoin/openssl && make install

#need to fix BerkeleyDB to get rid of the 1st flag
RUN /bin/bash /home/bitcoin/bitcoin/autogen.sh
RUN cd /home/bitcoin/bitcoin && ./configure --with-incompatible-bdb --without-qt
RUN cd /home/bitcoin/bitcoin && make
RUN cd /home/bitcoin/bitcoin && make install

RUN mkdir -p /opt/bitcoin
COPY bitcoin.conf /opt/bitcoin/bitcoin.conf
COPY bitcoin.service /etc/systemd/system/bitcoind.service
#we've build the binary, now copy it so we can execute anywhere in the container
RUN chown -R bitcoin:bitcoin /home/bitcoin
RUN chown -R bitcoin:bitcoin /opt/bitcoin
RUN chown -R bitcoin:bitcoin /opt/bitcoin
RUN systemctl enable bitcoind
RUN systemctl enable sshd

CMD /sbin/init
#CMD ["/bin/bash"]
