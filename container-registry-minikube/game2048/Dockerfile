FROM alpine:latest

RUN apk --update add nginx

COPY nginx.conf /etc/nginx
COPY ./2048 /usr/share/nginx/html

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
