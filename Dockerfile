# build front-end
FROM node:lts-alpine AS builder

COPY ./ /app
WORKDIR /app

RUN npm install pnpm -g && pnpm install && pnpm run build

# service
FROM node:lts-alpine

COPY /service /app
COPY --from=builder /app/dist /app/public

WORKDIR /app
RUN npm install pnpm -g && pnpm install

ENV OPENAI_API_KEY

EXPOSE 8080

CMD ["pnpm", "run", "start"]
