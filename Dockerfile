FROM node:16-alpine as builder 
#tag this phase as "builder"

WORKDIR '/app'
# /app/build <-- all stuff the stuff

COPY package.json . 
#copy packagejson to app directory
RUN npm install 

COPY . .
#copy all source code, don't need volumes, this will be production, no code change
RUN ["npm", "run", "build"]


FROM nginx
# only want app/build from previous block for production
# previous block is complete, FROM = new block

COPY  --from=builder /app/build /usr/share/nginx/html
#copy from other phase, location, copy TO: /usr/share/nginx/html <--nginx config, see docs
#copy build folder to nginx container

#no 'start nginx', default command of nginx starts it when we start container