#!/bin/bash

# Update package list
sudo apt update

# Install Python 3 and pip
sudo apt install -y python3 python3-pip

# Install virtualenv using apt
sudo apt install -y python3-venv

# Create a virtual environment
python3 -m venv .venv

# Activate the virtual environment
source .venv/bin/activate

# Install required libraries from requirements.txt if it exists
if [ -f requirements.txt ]; then
    pip install -r requirements.txt
fi

# Install Jupyter Notebook
pip install jupyter

# Install IPython kernel
pip install ipykernel

# Add the virtual environment as a Jupyter kernel
python -m ipykernel install --user --name=py_network_demo --display-name "Python (py_network_demo)"

echo "Python 3, virtual environment, and Jupyter Notebook setup complete."