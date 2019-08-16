FROM python:3.7

MAINTAINER tsukumogami
ENV P_APP 9090
ENV P_STATS 9191

RUN groupadd -r uwsgi && useradd -r -g uwsgi uwsgi
RUN pip install Flask==0.10.1 uWSGI==2.0.15 requests==2.5.1 redis==2.10.3
WORKDIR /app
COPY app /app
COPY cmd.sh /

EXPOSE $P_APP
EXPOSE $P_STATS

USER uwsgi

CMD ["/cmd.sh"]
