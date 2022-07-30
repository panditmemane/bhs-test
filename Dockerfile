FROM nginx
RUN rm -rf /etc/nginx/conf.d/*
COPY default.conf /etc/nginx/conf.d/default.conf
RUN rm -rf /usr/share/nginx/html/*
COPY index.html /usr/share/nginx/html

#/usr/share/nginx/html