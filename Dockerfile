FROM swift:5.3

MAINTAINER lschlesinger

WORKDIR /app

# copy sources
COPY Package.swift /app
COPY Package.resolved /app
COPY Sources /app
COPY Tests /app

# install deps and build app
RUN swift package clean
RUN swift build

# run app
CMD swift run --skip-build