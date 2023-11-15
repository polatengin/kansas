FROM node:21.1-bullseye AS build
WORKDIR /app
COPY . .
RUN npm install
RUN npm run build

FROM node:21.1-alpine3.18
WORKDIR /app
ENV NODE_ENV production
COPY --from=build /app/next.config.js ./
COPY --from=build /app/public ./public
COPY --from=build /app/.next ./.next
COPY --from=build /app/node_modules ./node_modules
COPY --from=build /app/package.json ./package.json
CMD ["npm", "run", "start"]

EXPOSE 3000
