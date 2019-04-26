FROM brainpower/cubicle as cubicle
FROM ocaml/opam2:ubuntu

COPY --from=cubicle /usr/local/bin/code-server /usr/local/bin/code-server
COPY --from=cubicle /usr/share/code /usr/share/code
COPY --from=cubicle /usr/bin/ext /usr/bin/ext
COPY --from=cubicle --chown=opam:opam /root/.code-server /home/opam/.code-server
RUN sudo ln -s /usr/share/code/bin/code /usr/bin/code

# code server deps
RUN sudo apt-get update && sudo apt-get install -y \
	net-tools \
	locales \
	libssl-dev \
	libx11-xcb-dev \
	libasound2

# code deps (ext)
RUN sudo apt-get update && sudo apt-get install -y \
	libgtk-3-dev \
	libxss-dev \
	libnss3

RUN sudo locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install ocaml dependencies
RUN sudo apt-get update
RUN sudo apt-get install fswatch m4 -y

RUN opam install OUnit Core dune utop merlin -y

RUN sudo mkdir /user
RUN sudo mkdir /ext

RUN sudo chown -R opam:opam /user
RUN sudo chown -R opam:opam /ext

RUN ext install freebroccolo.reasonml 1.0.38 
RUN ext install maelvalais.dune 0.0.5

RUN cp -a /ext/. /home/opam/.code-server/extensions
RUN cat /home/opam/.code-server/extensions/ms-vsliveshare.vsliveshare-1.0.91/out/deps/linux-prereqs.sh

RUN sed 's/libssl1.0.0/libssl1.1/g'  /home/opam/.code-server/extensions/ms-vsliveshare.vsliveshare-1.0.91/out/deps/linux-prereqs.sh > linux-prereqs.sh
RUN sudo /bin/bash linux-prereqs.sh

RUN . /home/opam/.opam/opam-init/init.sh

RUN opam install ocp-indent