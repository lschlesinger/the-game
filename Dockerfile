FROM swift:5.3

MAINTAINER lschlesinger

WORKDIR /app

# copy sources
COPY . .

# install deps and build app
RUN swift package clean
RUN swift build

# run app
CMD swift run --skip-build