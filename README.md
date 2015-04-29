# docker-bitcoind
# Container with bitcoin daemon running under systemd, and ssh acess
Building this container will build a fresh openssl (OpenSSL_1_0_2-stable) and bitcoind (0.9) with modified systemd for docker support. bitcoind rpc_user and rpc_password randomly generated at build time with openssl. Starting the container will start systemd with sshd and bitcoind enabled. ssh access provided with bitcoin user and sudo escalation privileges. 

      $ ssh bitcoin@172.0.1.98 #docker container ip address
      $ sudo systemctl status bitcoind
          bitcoind.service - Start bitcoind daemon with conf [/opt/bitcoin/bitcoin.conf]
          Loaded: loaded (/etc/systemd/system/bitcoind.service; enabled)
          Active: active (running) since Wed 1999-01-01 01:01 UTC; 3h 2min ago
          Main PID: 10148 (bitcoind)
          CGroup: /system.slice/docker-a279961d26be1842146538d3455285a329d28070ea1d8b51c377a5ce23076d1a.scope/system.slice/bitcoind.service
           └─10148 /usr/local/bin/bitcoind -datadir=/opt/storage/bitcoin - conf=/opt/bitcoin/bitcoin.conf
        Apr 29 14:45:33 a279961d26be systemd[1]: Started Start bitcoind daemon with conf         [/opt/bitcoin/bitcoin.conf].
