import random
from locust import HttpUser, between, task


class WebsiteUser(HttpUser):
    wait_time = between(0.9, 1)
 
    @task
    def index(self):
        
        resp = self.client.get(f'/segments')
        return resp
