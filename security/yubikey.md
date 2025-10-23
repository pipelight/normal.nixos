# Enroll a yubikey.

## For LUKS devices encryption/decryption.

Unroll a fido2 device.

For automatic device decryption use the option
`fido2-with-user-presence=false`

```sh
systemd-cryptenroll /dev/disk --fido2-device=device
```
