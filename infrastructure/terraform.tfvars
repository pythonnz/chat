#--------------------------------------------------------------
# Network
#--------------------------------------------------------------
external_network_id = "f10ad6de-a26d-4c29-8c64-2a7418d47f8f"

#--------------------------------------------------------------
# Instances
#--------------------------------------------------------------
name = "synapse-homeserver"
image = "ubuntu-18.04-x86_64"
flavor = "c1.c1r4"
public_key_name = "chris"
public_key_value = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQCwcdE5l07+no9EccvG4ZDoi9EM3+3DY0QQgGsETMamogHsthiQOJBsDPHrWR57KI8QJxn4d+kaBRpFqexn4XziFUGrJEVgRyAXY3Qt7fwSHFDdU6o+aoRTZfH8eiPpBe4UYF6JE9KXsMOQHuIza4HLHJ/agxuB17Kteq6BBCT08yzgYYkJvjJQ72TbR+i5HyB72OMctAQeolLcIA2AW4iTYfmcHLopT4mrtzyFKD99zsjPFZP1UPfYrJzIivu8F7i5JjApO6hy11KbdKJeb3jYLWjCSp6/+OLo75nwcwe6f4R2pk1L7QT/z5ZvidzEBfljKoU7ouBbwTs2jnGlafB7BdZBkVHzBkInfHN6paWZRhzEL5txEllAd2uZqzQ/3zlsfMQLfKfKP5ODK7JPBHRxaIW41gNuR/BYHDbWuutSLae9niM8cVB/JwfMyqZjzXrvcBBoDqUanJ2TsPo6l3DQwvKcXQ9n48WGMnEA2mLfc0e29PPJZkXh0bZmJVeA+40aVXzLEIMkW7dHQuCNEV49qntGfFz6gazQyfzxOpV1nx5cfzZ9r5lku09R7QIQDJ1MhVUym6tOkYW1QveoIlZBQccEnh6gyo7rF4qgOLQXhoAp889CR55Nudvd/TpaGwiQ2N8Cng85fJCVenPH6t0tRt3uYq0JPzUf8bLmZPcBKQ== chrisherrmann@chrisherrmann-pc"

#--------------------------------------------------------------
# Volume
#--------------------------------------------------------------
volume_size = 100
volume_device = "/dev/vdb"
