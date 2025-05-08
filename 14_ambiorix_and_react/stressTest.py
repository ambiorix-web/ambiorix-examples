from locust import HttpUser, task, between

class MyUser(HttpUser):
    wait_time = between(1, 5)

    @task
    def get_status(self):
        self.client.get("/api/status")

    @task
    def get_all_users(self):
        self.client.get("/api/users")

    @task
    def get_user_count(self):
        self.client.get("/api/user-count")

    @task
    def get_user_location(self):
        self.client.get("/api/user-location")

    @task
    def get_user_gender_info(self):
        self.client.get("/api/user-gender-count/2023")
