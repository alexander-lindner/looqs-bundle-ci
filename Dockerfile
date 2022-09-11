FROM gentoo/stage3

ADD ./looqs-bundle/ /opt/looqs-bundle/
WORKDIR /opt/looqs-bundle
RUN chmod 777 . -R

RUN ./scripts/3-setup-gentoo.sh
RUN useradd -m -G users,wheel,audio -s /bin/bash user
CMD ["/bin/bash", "-c","./scripts/4-build-looqs.sh","&&",'chown user -R out','&&','su user -c "cd $(pwd); ./scripts/5-bundle.sh"']
