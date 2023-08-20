### Tools that we will need to deploy to the cluster
1. Kafka
2. Zookeeper: keeps different brokers in sync and helps coordinate topics and messages. 

#### Prerequisites
1. Setup kubernetes cluster.
2. Install KCat command line utility, that will enable creating and publishing messages: https://github.com/edenhill/kcat

##### Setting up kafka
1. Create a kafka namespace
```shell
kubectl apply -f namespace.yaml
```
2. Create a kafka service
```shell
kubectl apply -f kafka-broker-service.yaml
```
3. Create a kafka deployment
```shell
kubectl apply -f kafka-broker-deployment.yaml
```

#### Setting up zookeeper
1. Create a zookeper service
```shell
kubectl apply -f zookeeper-service.yaml
```
2. Create a zookeper deployment
```shell
kubectl apply -f zookeeper-deployment.yaml
```

#### Testing the setup
1. Expose a port on your local machine, in order to test we can send and retrieve messages from the kafka cluster
```shell
kubectl port-forward kafka-broker-5c55f544d4-hrgnv 9092 -n kafka
```
replace kafka-broker-5c55f544d4-hrgnv with your pod name

2. To publish a message
```shell
sh publish-message.sh
```
3. To consume messages
```shell
sh consume-message.sh
```


