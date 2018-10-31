FROM base/archlinux:latest

RUN pacman -Syy && \
    yes | pacman -S sudo autoconf pkg-config automake libtool git fakeroot gcc libzip libglvnd luarocks love patch make && \
    luarocks install lua-libzip && \
    luarocks install love-release

ADD /sudoers.txt /etc/sudoers
RUN chmod 440 /etc/sudoers

RUN useradd --no-create-home --shell=/bin/false builder && usermod -L builder

USER builder

ENV PATH="$PATH:~/bin"
