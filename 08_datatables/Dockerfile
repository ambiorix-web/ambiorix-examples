FROM rocker/r-ver:4.3.3
RUN apt-get update && apt-get install -y \
  git-core \
  libssl-dev
WORKDIR /app
COPY . .
RUN rm -rdf renv/library
RUN R -e "renv::restore()"
EXPOSE 3000
CMD ["Rscript", "index.R"]
