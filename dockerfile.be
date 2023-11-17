FROM python:3.9

RUN git clone https://github.com/Jmo-101/Eks_ecommerce_app.git

WORKDIR /Eks_ecommerce_app/backend

RUN pip install -r requirements.txt

EXPOSE 8000

RUN python manage.py migrate

CMD python manage.py runserver 0.0.0.0:8000
