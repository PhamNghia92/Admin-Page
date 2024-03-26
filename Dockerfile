# Sử dụng Ubuntu 20.04 làm hệ điều hành cơ sở
FROM ubuntu:20.04

# Cập nhật gói và cài đặt các gói cơ bản
RUN apt-get update -y && apt-get upgrade -y && apt-get install -y software-properties-common

# Cài đặt Nginx
RUN apt-get install -y nginx

# Cài đặt PHP 8.2
RUN apt-get install -y software-properties-common
RUN add-apt-repository ppa:ondrej/php
RUN apt-get install php8.2-fpm php8.2-common php8.2-mysql php8.2-xml php8.2-xmlrpc php8.2-curl php8.2-gd php8.2-imagick php8.2-cli php8.2-dev php8.2-imap php8.2-mbstring php8.2-soap php8.2-zip php8.2-bcmath -y
RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer


# Cài đặt Node.js và npm
ENV NODE_VERSION=19.4.0
RUN apt install -y curl
RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.0/install.sh | bash
ENV NVM_DIR=/root/.nvm
RUN . "$NVM_DIR/nvm.sh" && nvm install ${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm use v${NODE_VERSION}
RUN . "$NVM_DIR/nvm.sh" && nvm alias default v${NODE_VERSION}
ENV PATH="/root/.nvm/versions/node/v${NODE_VERSION}/bin/:${PATH}"
RUN node --version
RUN npm --version

# Cài đặt Vue.js
RUN npm install -g vue

# Xóa bất kỳ gói không cần thiết và dọn dẹp
RUN apt-get autoremove -y && apt-get clean

# Mở cổng 80 cho Nginx
EXPOSE 80

# Khởi động Nginx và PHP-FPM
CMD ["nginx", "-g", "daemon off;"]
