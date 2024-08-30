FROM jcoenep/ambiorix
WORKDIR /app
COPY . .
RUN R -e "renv::restore()"
EXPOSE 3000
CMD [ "Rscript", "index.R" ]

