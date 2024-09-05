## UDP Custom Service
#### * Version ⇢ 2.1b
---
UDP (User Datagram Protocol) is a network communication protocol that operates on top of IP (Internet Protocol). It is a simpler protocol compared to TCP (Transmission Control Protocol), as it aims for speed rather than reliability.
---

# Supported OS
- ubuntu 20.04 [x86_64] ✅ _(recommended)_
- debian 10 [buster] ✅
- [arm] ❌

## Install
```
sudo -s
``` 
```
wget https://raw.githubusercontent.com/Rerechan02/UDP/main/ssh/udp.sh && chmod +x udp.sh && ./udp.sh
```


## Manually

## Note: 
 * Use optional port exclude when port udp between 1-65535 already use by other udp tunnel, like badvpn, ovpn udp and other.
 * Edit path config /etc/udp/config.json, after changing it then reboot
 * Optional port exclude separated by coma, ex. 53,5300

## Telegram 
 > [Rerechan02](https://t.me/Rerechan02)