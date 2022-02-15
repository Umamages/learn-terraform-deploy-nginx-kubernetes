FROM python:3.8

WORKDIR /c/USers/getum/Documents/learn-terraform-deploy-nginx-kubernetes

COPY . .

EXPOSE 8003

CMD ["python", "./app.py"]
