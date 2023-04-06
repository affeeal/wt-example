# The build stage

FROM alpine:3.17.3 AS build

RUN apk update && \
    apk add --no-cache \
      build-base \
      cmake \
      wt-dev

WORKDIR /wt_example

COPY src/ ./src/
COPY CMakeLists.txt .

WORKDIR /wt_example/build

RUN cmake -DCMAKE_BUILD_TYPE=Debug .. && \
    cmake --build .

# The final image

FROM alpine:3.17.3

RUN apk update && \
    apk add --no-cache \
      libstdc++ \
      wt

RUN addgroup -S shs && adduser -S shs -G shs
USER shs

COPY --chown=shs:shs --from=build \
    ./wt_example/build/src/wt_example.wt \
    ./wt_example.wt

CMD [ "./wt_example.wt", \
      "--docroot", ".", \
      "--http-address", "0.0.0.0", \
      "--http-port", "9090" ]

EXPOSE 9090
