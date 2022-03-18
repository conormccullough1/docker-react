FROM node:16-alpine as builder

# The above means that node:16-alpine will be referred to as "builder". Essentially creates it as a variable.

WORKDIR '/app'

COPY --chown=node:node package.json .
RUN npm install

COPY --chown=node:node . .
USER node

RUN npm run build

#Specify the start of a second build phase:

FROM nginx 
EXPOSE 80
# The second FROM statement indicates the termination of the first block

COPY --from=builder /app/build /usr/share/nginx/html

#--from=builder tells it to copy something from the builder phase. You then specify the folder you want to copy, then specify where you want to specify the stuff to.