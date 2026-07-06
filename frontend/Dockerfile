FROM node:20-alpine
# Usar a tag '-alpine' reduz o tamanho da imagem drasticamente de ~1GB para ~200MB.

WORKDIR /app

# Copia os arquivos de dependência primeiro para aproveitar o cache
COPY package*.json ./
RUN npm install

# Copia o restante do código
COPY . .

EXPOSE 4200

ENV NG_CLI_ANALYTICS=false

CMD ["npm", "run", "start", "--", "--host=0.0.0.0"]