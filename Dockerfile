FROM brainpower/cubicle:code-1.939-share-1.0.125

RUN ext install freebroccolo.reasonml 
RUN ext install maelvalais.dune

RUN apt-get update
RUN apt-get install software-properties-common -y 
RUN add-apt-repository ppa:avsm/ppa
RUN apt-get update
RUN apt-get install opam m4 fswatch mercurial darcs -y

SHELL ["/bin/bash", "--login" , "-c"]
RUN opam init --disable-sandboxing
RUN opam switch create 4.07.1

RUN opam install dune ocp-indent utop earlybird -y

RUN ext install hackwaly.ocaml-debugger
RUN opam install user-setup -y

ENV OPAM_SWITCH_PREFIX='/root/.opam/4.07.1'
ENV CAML_LD_LIBRARY_PATH='/root/.opam/4.07.1/lib/stublibs:/root/.opam/4.07.1/lib/ocaml/stublibs:/root/.opam/4.07.1/lib/ocaml'
ENV OCAML_TOPLEVEL_PATH='/root/.opam/4.07.1/lib/toplevel'
ENV MANPATH=':/root/.opam/4.07.1/man'
ENV PATH='/root/.opam/4.07.1/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin'
