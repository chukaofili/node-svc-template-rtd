FROM node:10.16.0-alpine AS dependencies

WORKDIR /www

COPY app/package.json app/yarn.lock ./
RUN yarn install --production --no-progress

# Copy over node_modules from the above image
FROM node:10.16.0-alpine

WORKDIR /www

COPY --from=dependencies /www/node_modules node_modules
COPY ./app ./

EXPOSE 3000

CMD ["yarn", "start"]
