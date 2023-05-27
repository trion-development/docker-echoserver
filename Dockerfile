FROM node:lts-slim as builder
#buildx only
#FROM --platform=${BUILDPLATFORM:-linux/amd64} node:lts-slim as builder

ARG TARGETPLATFORM
ARG BUILDPLATFORM
ARG TARGETOS
ARG TARGETARCH

WORKDIR /app
RUN npm install -g pkg
COPY build.sh /app/
COPY index.js /app/

RUN ./build.sh


FROM alpine
#buildx only
# FROM --platform=${BUILDPLATFORM:-linux/amd64} alpine

CMD ["/app"]
EXPOSE 3000
RUN apk -U add --no-cache libstdc++ libgcc libc6-compat gcompat
COPY --from=builder /app/index /app
USER 1000
