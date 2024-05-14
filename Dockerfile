FROM nginx:latest
RUN rm -rf /usr/share/nginx/html/index.html
COPY ./ArtLab/. /usr/share/nginx/html/
#