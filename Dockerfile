FROM node:latest

LABEL MAINTAINER="zipme"
LABEL version="1.0"

# Create app directory
RUN mkdir -p /app
COPY . /app

# Expose the app port
EXPOSE 3000

ONBUILD ARG AUTO_BUILD=no
ONBUILD ARG REBUILD_SASS=yes
# ONBUILD ARG PROCESS_NUM=0

ONBUILD ENV HOST 0.0.0.0

# Copy files.
ONBUILD COPY . /app
ONBUILD WORKDIR /app
ONBUILD RUN rm -rf ./node_modules
ONBUILD RUN npm install
ONBUILD RUN if [ "${REBUILD_SASS}" = "yes" ]; then npm rebuild node-sass; fi
ONBUILD RUN if [ "${AUTO_BUILD}" = "yes" ]; then ./node_modules/.bin/nuxt build; fi

CMD ["node_modules/pm2/bin/pm2", "start", "node_modules/nuxt/bin/nuxt-start", "-i", "${PROCESS_NUM}", "--attach"]
