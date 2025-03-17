class OrderService:
    keycloak_client = None

    def set_keycloak_client(self, keycloak_client):
        self.keycloak_client = keycloak_client