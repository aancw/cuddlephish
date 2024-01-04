# Use Node.js 14 Alpine
FROM node:14-alpine

RUN apk add chromium

# Mode package.json into a tmp directory
ADD package.json /tmp/package.json

# Remove the old build directory
RUN rm -rf build

# Install the dependancies
RUN cd /tmp && npm install -q

ADD ./ /src

# Copy to dependancies to the src directory
RUN rm -rf /src/node_modules && cp -a /tmp/node_modules /src/

WORKDIR /src

ARG target_url
ARG target_name

RUN node add_target.js ${target_url}

# Run the built application
CMD ["node index.js ${target_name}"]
