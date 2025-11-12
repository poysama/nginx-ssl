FROM nginx:alpine

# Copy nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf

# Generate self-signed certificate for HTTPS/HTTP2
RUN apk add --no-cache openssl && \
    mkdir -p /etc/nginx/ssl && \
    openssl req -x509 -newkey rsa:2048 -keyout /etc/nginx/ssl/cert.key -out /etc/nginx/ssl/cert.pem \
    -days 365 -nodes -subj "/C=US/ST=State/L=City/O=Test/CN=localhost" && \
    apk del openssl

# Expose HTTPS port
EXPOSE 9081

CMD ["nginx", "-g", "daemon off;"]
