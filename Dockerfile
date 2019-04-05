FROM brainpower/cubicle as cubicle
FROM ocaml/opam2:ubuntu

COPY --from=cubicle /usr/bin/curl /usr/bin/curl
COPY --from=cubicle /usr/bin/ext /usr/bin/ext
COPY --from=cubicle /usr/bin/vsix-add /usr/bin/vsix-add
COPY --from=cubicle /usr/local/bin/code-server /usr/bin/code-server
COPY --from=cubicle --chown=opam:opam /root/.code-server /home/opam/.code-server

# code server deps
RUN sudo apt-get update && sudo apt-get install -y \
	net-tools \
	locales

RUN sudo locale-gen en_US.UTF-8

ENV LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8

# Install ocaml dependencies
RUN sudo apt-get update
RUN sudo apt-get install fswatch m4 -y

RUN opam install OUnit Core dune utop merlin -y

