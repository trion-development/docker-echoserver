FROM node:lts-slim as builder

WORKDIR /app
RUN npm install -g pkg
COPY index.js index.js
RUN pkg index.js --compress GZip 
RUN ls -lah; pwd

FROM alpine
RUN apk update && apk add --no-cache libstdc++ libgcc libc6-compat gcompat
CMD ["/app"]
EXPOSE 3000
USER 1000
COPY --from=builder /app/index-linux /app
