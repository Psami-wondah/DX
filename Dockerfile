# Create the react frontend build
FROM node:16.19.1-alpine3.17 AS client

ARG REACT_APP_API
ARG REACT_APP_GOOGLE_API_CLIENT_ID
ARG REACT_APP_GOOGLE_API_DEV_KEY
ARG REACT_APP_AUTH0_DOMAIN
ARG REACT_APP_AUTH0_CLIENT
ARG REACT_APP_AUTH0_AUDIENCE

ENV REACT_APP_API=$REACT_APP_API
ENV REACT_APP_GOOGLE_API_CLIENT_ID=$REACT_APP_GOOGLE_API_CLIENT_ID
ENV REACT_APP_GOOGLE_API_DEV_KEY=$REACT_APP_GOOGLE_API_DEV_KEY
ENV REACT_APP_AUTH0_DOMAIN=$REACT_APP_AUTH0_DOMAIN
ENV REACT_APP_AUTH0_CLIENT=$REACT_APP_AUTH0_CLIENT
ENV REACT_APP_AUTH0_AUDIENCE=$REACT_APP_AUTH0_AUDIENCE

# Install and link the charts
WORKDIR /app/charts/
COPY ./rawgraphs-charts ./
RUN yarn install
RUN yarn build
RUN yarn link

# Build the react app
WORKDIR /app/client/
COPY ./dx.client ./
RUN yarn link "@rawgraphs/rawgraphs-charts"
RUN yarn install
RUN yarn build

CMD ["yarn", "docker-prod"]
