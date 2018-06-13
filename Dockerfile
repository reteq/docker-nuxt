FROM node:latest

# Create app directory
RUN mkdir -p /app
COPY . /app

# Expose the app port
EXPOSE 3000

ONBUILD ARG rebuildsass=yes
ONBUILD ARG autobuild=no

# Copy files.
ONBUILD COPY . /app
ONBUILD WORKDIR /app
ONBUILD RUN npm install
ONBUILD RUN if [ "${rebuildsass}" = "yes" ]; then npm rebuild node-sass; fi
ONBUILD RUN if [ "${autobuild}" = "yes" ]; then ./node_modules/.bin/nuxt build; fi

CMD ["/app/run.sh"]
