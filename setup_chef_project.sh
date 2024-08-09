#!/bin/bash

# Define variables
CHEF_WORKSTATION_URL="https://packages.chef.io/files/stable/chef-workstation/24.4.1064/el/8/chef-workstation-24.4.1064-1.el8.x86_64.rpm"
REPO_NAME="chef-repo"
COOKBOOK_NAME="my_cookbook"
RECIPE_PATH="$REPO_NAME/cookbooks/$COOKBOOK_NAME/recipes/default.rb"

# Update the system
echo "Updating system packages..."
sudo yum update -y

# Download and install Chef Workstation
echo "Downloading Chef Workstation..."
wget $CHEF_WORKSTATION_URL -O chef-workstation.rpm

echo "Installing Chef Workstation..."
sudo rpm -Uvh chef-workstation.rpm

# Verify installation
echo "Verifying Chef Workstation installation..."
chef --version

# Troubleshoot missing library issue
if ! sudo chef --version &> /dev/null; then
    echo "Encountered error with missing library. Installing compatibility library..."
    sudo yum install libxcrypt-compat -y
fi

# Set up Chef repository
echo "Setting up Chef repository..."
chef generate repo $REPO_NAME
cd $REPO_NAME

# Create a cookbook
echo "Creating a cookbook..."
chef generate cookbook cookbooks/$COOKBOOK_NAME
cd cookbooks/$COOKBOOK_NAME

# Write a recipe
echo "Writing a recipe..."
mkdir -p recipes
cat <<EOF > recipes/default.rb
file '/tmp/greeting.txt' do
  content 'Hello, Chef!'
end
EOF

# Run Chef Client in local mode
echo "Running Chef Client in local mode..."
sudo chef-client --local-mode --runlist recipe[$COOKBOOK_NAME::default]

# Verify output
echo "Verifying output..."
cat /tmp/greeting.txt

echo "Chef project setup complete."
