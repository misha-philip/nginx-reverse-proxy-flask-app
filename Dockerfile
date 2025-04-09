FROM node:14-alpine3.11 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .

FROM python:2.7-alpine3.11
WORKDIR /app
COPY --from=builder /app/flask-app ./flask-app
COPY --from=builder /app/static ./static
COPY --from=builder /app/entrypont.sh ./entrypoint.sh
COPY flask-app/requirements.txt ./
RUN pip install -r requirements.txt
RUN apk add --no-cache curl
RUN adduser --disabled-password --gecos "" appuser
RUN chown -R appuser:appuser && chmod -R 755 /app
EXPOSE 5000
ENTRYPOINT [ "./entrypoint.sh" ]