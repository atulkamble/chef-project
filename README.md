# chef-project
Basic Chef Server Project

To install Chef on Amazon Linux 2023, you need to follow a few steps to ensure all dependencies are correctly handled and the Chef tool is installed properly. Here’s a step-by-step guide:

### Launch EC2 - Connect it via SSH


### Step 1: Update the System
First, update your system packages to make sure you have the latest updates and security patches.

```bash
sudo yum update -y
```

### Step 2: Download and Install Chef Workstation
Chef Workstation provides all the tools you need to manage your infrastructure and run Chef recipes.

1. **Download the Chef Workstation package:**

    ```bash
    wget https://packages.chef.io/files/stable/chef-workstation/24.4.1064/el/8/chef-workstation-24.4.1064-1.el8.x86_64.rpm
    ```

2. **Install the downloaded package:**

    ```bash
    sudo rpm -Uvh chef-workstation-24.4.1064-1.el8.x86_64.rpm
    ```

### Step 3: Verify the Installation
Check that the Chef Workstation is installed correctly by verifying the version:

```bash
chef --version
```

### Step 4: Set Up a Chef Repository


### Troubleshoot
If getting /opt/chef-workstation/embedded/bin/ruby: error while loading shared libraries: libcrypt.so.1: cannot open shared object file: No such file or directory ERROR 
Try
```
sudo yum install libxcrypt-compat -y
```
1. **Create a Chef repository:**
    ```bash
    chef generate repo chef-repo
    yes
    cd chef-repo
    ```

2. **Create a Cookbook:**

    ```bash
    chef generate cookbook cookbooks/my_cookbook
    cd cookbooks/my_cookbook
    ```

3. **Write a Recipe:**
   Edit the `recipes/default.rb` file in your cookbook:
   ```
   ls recipes/
   sudo nano recipes/default.rb
   ```
    ```ruby
    file '/tmp/greeting.txt' do
      content 'Hello, Chef!'
    end
    ```

### Step 5: Run Chef Client in Local Mode
Test your cookbook by running Chef in local mode:

```bash
sudo chef-client --local-mode --runlist recipe[my_cookbook::default]
yes
cat /tmp/greeting.txt
```
