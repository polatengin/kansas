FROM node:16.14.0-buster AS build

WORKDIR /app

COPY . .

RUN npm install
RUN npm run build

FROM node:16.14.0-alpine3.14

WORKDIR /app

ENV NODE_ENV production

COPY --from=build /app/next.config.js ./
COPY --from=build /app/public ./public
COPY --from=build /app/.next ./.next
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json

EXPOSE 3000

CMD ["npm", "run", "start"]
