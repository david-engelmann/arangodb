#FROM ubuntu:22.04
#
#RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
#     && apt-get -y install --no-install-recommends \
#        curl \
#     && apt-get update && apt-get -y upgrade
#
#RUN bash -c "sh <(curl -fsSL https://raw.githubusercontent.com/ocaml/opam/master/shell/install.sh)"
#
#
#ENV PATH=~/.opam/
FROM ocaml/opam:debian

ARG USERNAME=vim
ARG USER_UID=1000
ARG USER_GID=$USER_UID

USER root

WORKDIR /app
RUN apt-get update && export DEBIAN_FRONTEND=noninteractive \
     && apt-get -y install --no-install-recommends \
        m4 libgmp-dev pkg-config libssl-dev \
     && apt-get update && apt-get -y upgrade

RUN if [ "$USER_GID" != "1000" ] || [ "$USER_UID" != "1000" ]; then \
    groupmod --gid $USER_GID $USERNAME \
    && usermod --uid $USER_UID --gid $USER_GID $USERNAME \
    && chown -R $USER_UID:$USER_GID /home/$USERNAME; \
    fi

RUN apt-get update && apt-get upgrade -y

#USER opam

RUN opam init && eval $(opam env) && opam update \
    && opam install async base uri cohttp cohttp-lwt-unix cohttp-async httpaf httpaf-lwt-unix lwt core_kernel ssl lwt_ssl jose ounit qcheck dune ocamlformat \
    && eval $(opam env)


COPY . .

