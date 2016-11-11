# Certificate Creator

Create self-signed certificates for use in the development of HTTPS services.

## Usage

docker run -v /dir/to/put/cert/in:/out qubyte/cert-creator -d <domain> -d <alt-domain> -d <alt-domain>

 - At least one domain is required using the `-d` or `--domain` flag.
 - A volume mount is required to place the key and certificate into.

Once the pair are created, you need to install the `.pem` file into your browser
and/or system keychain, and trust it for SSL.

## TODO

More information on installing certificates.