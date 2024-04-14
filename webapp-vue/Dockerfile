FROM node:16.17.0 as builder

ENV WORKDIR=/frontserverdir

WORKDIR $WORKDIR

COPY ./ $WORKDIR/

ARG version
ENV COMMITID=$version

RUN npm i -g pnpm

RUN pnpm install
RUN pnpm build

FROM nginx:alpine as prod

RUN mkdir /frontserverdir

COPY --from=builder /frontserverdir/dist /frontserverdir

EXPOSE 80
