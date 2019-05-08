FROM brainpower/cubicle:code-1.939-share-1.0.125

RUN ext install freebroccolo.reasonml 
RUN ext install maelvalais.dune

RUN apt-get update
RUN apt-get install software-properties-common -y 
RUN add-apt-repository ppa:avsm/ppa
RUN apt-get update
RUN apt-get install opam m4 -y
RUN opam init -y --disable-sandboxing
RUN eval `opam env`

RUN opam switch create 4.07.1

SHELL ["/bin/bash", "--login" , "-c"]
