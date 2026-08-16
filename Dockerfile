FROM node:alpine AS builder
WORKDIR "/app"
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

FROM nginx
# only elastic beanstalk uses EXPOSE for port mapping 
EXPOSE 80
COPY --from=builder /app/build /usr/share/nginx/html
# We don't have to include default command since nginx runs that