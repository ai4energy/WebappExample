FROM node:20.12.2 as builder
ENV WORKDIR=/frontserverdir
WORKDIR $WORKDIR
COPY ./ $WORKDIR/
ARG version
ENV COMMITID=$version
RUN npm i -g pnpm
RUN pnpm install --frozen-lockfile
RUN pnpm build
FROM nginx:alpine as prod
COPY --from=builder /frontserverdir/dist /usr/share/nginx/html/
EXPOSE 80
