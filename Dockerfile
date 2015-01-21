FROM node:0.10.33
# replace this with your application's default port

	RUN npm cache clean
# Install coffee-script
  RUN npm install -g coffee-script

# Install grunt
  RUN npm install -g grunt-cli

# Install Bower
  RUN npm install -g bower

ENV NODE_ENV development
ENV PORT 3001 

EXPOSE 9000
EXPOSE 9876
EXPOSE 35729
EXPOSE 4444
EXPOSE 80
EXPOSE 3001