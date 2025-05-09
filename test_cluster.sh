#!/bin/bash

# Test script for Kubernetes cluster setup

# Check if kubectl is installed
echo "Checking for kubectl..."
if ! command -v kubectl >/dev/null 2>&1; then
    echo "FAIL: kubectl not found. Install it with 'sudo apt install kubectl'."
    exit 1
fi
echo "PASS: kubectl found"

# Copy kubeconfig from master (assumes SSH access)
echo "Copying kubeconfig from master..."
scp -i ~/.ssh/id_rsa ubuntu@master_ip:/home/ubuntu/.kube/config ~/.kube/config
if [ $? -eq 0 ]; then
    echo "PASS: kubeconfig copied"
else
    echo "FAIL: Failed to copy kubeconfig"
    exit 1
fi

# Test 1: Check cluster nodes
echo "Testing cluster nodes..."
if kubectl get nodes | grep -q "Ready"; then
    echo "PASS: All nodes are Ready"
else
    echo "FAIL: Not all nodes are Ready"
    exit 1
fi

# Test 2: Check Calico pods
echo "Testing Calico network pods..."
if kubectl get pods -n kube-system | grep -q "calico"; then
    echo "PASS: Calico pods are running"
else
    echo "FAIL: Calico pods not found"
    exit 1
fi

# Test 3: Deploy test pod
echo "Deploying test pod..."
kubectl apply -f - <<EOF
apiVersion: v1
kind: Pod
metadata:
  name: test-pod
spec:
  containers:
  - name: nginx
    image: nginx:latest
EOF
sleep 10
if kubectl get pod test-pod | grep -q "Running"; then
    echo "PASS: Test pod is running"
else
    echo "FAIL: Test pod failed to run"
    exit 1
fi

# Clean up
kubectl delete pod test-pod
echo "All tests completed!"
