FROM gentoo/stage3

ADD ./looqs-bundle/ /opt/looqs-bundle/
WORKDIR /opt/looqs-bundle
RUN chmod 777 . -R

RUN ./scripts/3-setup-gentoo.sh
RUN useradd -m -G users,wheel,audio -s /bin/bash user
RUN mkdir ./out
ADD ./entrypoint.sh /entrypoint.sh
CMD ["/entrypoint.sh"]
